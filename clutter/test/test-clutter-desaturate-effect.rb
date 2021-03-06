# Copyright (C) 2014  Ruby-GNOME2 Project Team
#
# This library is free software; you can redistribute it and/or
# modify it under the terms of the GNU Lesser General Public
# License as published by the Free Software Foundation; either
# version 2.1 of the License, or (at your option) any later version.
#
# This library is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
# Lesser General Public License for more details.
#
# You should have received a copy of the GNU Lesser General Public
# License along with this library; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301  USA

class ClutterDesaturateEffectTest < Test::Unit::TestCase
  include ClutterTestUtils

  def setup
    default_factor = 1.0
    @desaturate_effect = Clutter::DesaturateEffect.new(default_factor)
  end

  def test_factor_accesssors
    factor = 0.8
    @desaturate_effect.factor = factor
    assert_equal(factor, @desaturate_effect.factor)
  end
end
