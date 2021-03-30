# encoding: UTF-8
#
# Copyright (c) 2010-2015 GoodData Corporation. All rights reserved.
# This source code is licensed under the BSD-style license found in the
# LICENSE file in the root directory of this source tree.

require 'gutdata/commands/user'

describe GutData::Command::User do
  before(:each) do
    @client = ConnectionHelper.create_default_connection
  end

  after(:each) do
    @client.disconnect
  end

  it "Is Possible to create GutData::Command::Membership instance" do
    cmd = GutData::Command::User.new()
    cmd.should be_a(GutData::Command::User)
  end

  describe "#show" do
    it "Shows profile" do
      GutData::Command::User.show(:client => @client)
    end
  end
end