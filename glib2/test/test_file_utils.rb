# -*- coding: utf-8 -*-

class TestGLibFileUtils < Test::Unit::TestCase
  include GLibTestUtils

  sub_test_case "#format_size_for_display" do
    def setup
      only_glib_version(2, 16, 0)
    end

    def test_kb
      assert_equal("1.0 KB", GLib.format_size_for_display(1024))
    end

    def test_10kb
      assert_equal("10.0 KB", GLib.format_size_for_display(1024 * 10))
    end

    def test_mb
      assert_equal("1.0 MB", GLib.format_size_for_display(1024 * 1024))
    end

    def test_gb
      assert_equal("1.0 GB", GLib.format_size_for_display(1024 * 1024 * 1024))
    end

    def test_over_guint32_value
      guint32_max = 2 ** 32 - 1
      assert_equal("4.0 GB", GLib.format_size_for_display(guint32_max + 1))
    end
  end

  sub_test_case "#format_size" do
    def setup
      only_glib_version(2, 30, 0)
    end

    def test_kb
      assert_equal("1.0 kB", GLib.format_size(1000))
    end

    def test_mb
      assert_equal("1.0 MB", GLib.format_size(1000 * 1000))
    end

    def test_gb
      assert_equal("1.0 GB", GLib.format_size(1000 * 1000 * 1000))
    end

    def test_over_guint32_value
      guint32_max = 2 ** 32 - 1
      assert_equal("4.3 GB", GLib.format_size(guint32_max + 1))
    end

    sub_test_case "flags" do
      sub_test_case ":iec_units" do
        def format_size(size)
          GLib.format_size(size, :flags => :iec_units)
        end

        def test_kib
          assert_equal("1.0 KiB", format_size(1024))
        end

        def test_mib
          assert_equal("1.0 MiB", format_size(1024 * 1024))
        end

        def test_gib
          assert_equal("1.0 GiB", format_size(1024 * 1024 * 1024))
        end
      end
    end
  end
end
