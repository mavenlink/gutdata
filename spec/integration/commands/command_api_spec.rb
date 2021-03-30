# encoding: UTF-8
#
# Copyright (c) 2010-2015 GoodData Corporation. All rights reserved.
# This source code is licensed under the BSD-style license found in the
# LICENSE file in the root directory of this source tree.

require 'gutdata/commands/api'

describe GutData::Command::Api do
  before(:each) do
    @connection = ConnectionHelper::create_default_connection
  end

  it "Is Possible to create GutData::Command::Api instance" do
    cmd = GutData::Command::Api.new()
    cmd.should be_a(GutData::Command::Api)
  end
end