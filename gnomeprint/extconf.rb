=begin
extconf.rb for Ruby/GnomePrint extention library
=end

require 'pathname'

base_dir = Pathname(__FILE__).dirname.expand_path
top_dir = base_dir.parent.expand_path
top_build_dir = Pathname(".").parent.expand_path

mkmf_gnome2_dir = top_dir + "glib2" + 'lib'
version_suffix = ""
unless mkmf_gnome2_dir.exist?
  if /(-\d+\.\d+\.\d+)\z/ =~ base_dir.basename.to_s
    version_suffix = $1
    mkmf_gnome2_dir = top_dir + "glib2#{version_suffix}" + 'lib'
  end
end

$LOAD_PATH.unshift(mkmf_gnome2_dir.to_s)

module_name = "gnomeprint2"
package_id = "libgnomeprint-2.2"

require 'mkmf-gnome2'

setup_win32(module_name, base_dir)

PKGConfig.have_package(package_id) or exit 1

["glib2"].each do |package|
  directory = "#{package}#{version_suffix}"
  build_dir = "#{directory}/tmp/#{RUBY_PLATFORM}/#{package}/#{RUBY_VERSION}"
  add_depend_package(package, "#{directory}/ext/#{package}",
                     top_dir.to_s,
                     :top_build_dir => top_build_dir.to_s,
                     :target_build_dir => build_dir)
end
add_depend_package("libart2", "libart/src", top_dir.to_s)

make_version_header("LIBGNOMEPRINT", package_id)

create_pkg_config_file("Ruby/GnomePrint", package_id,
                       nil, "ruby-gnomeprint2.pc")
create_makefile_at_srcdir(module_name, (base_dir + "src").to_s,
                          "-DRUBY_GNOMEPRINT2_COMPILATION")
create_top_makefile
