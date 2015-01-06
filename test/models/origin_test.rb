# encoding: UTF-8

# Copyright 2011-2013 innoQ Deutschland GmbH
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

require File.join(File.expand_path(File.dirname(__FILE__)), '../test_helper')

class OriginTest < ActiveSupport::TestCase
  def test_origin_generation
    assert_match /_[0-9a-z]{8}/, Iqvoc::Origin.new.to_s
  end

  def test_origin_validation
    %w(air_sports _0997ba7fe13f13d9 _:A01).each do |origin|
      assert Iqvoc::Origin.new(origin).valid?
    end

    refute Iqvoc::Origin.new('1').valid?, 'should not start with a number'
    refute Iqvoc::Origin.new('fußball').valid?, 'should not contain special chars'
    refute Iqvoc::Origin.new('_:fußball').valid?, 'blank node should not contain special chars'
  end
end
