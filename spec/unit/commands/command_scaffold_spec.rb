# encoding: UTF-8
#
# Copyright (c) 2010-2015 GoodData Corporation. All rights reserved.
# This source code is licensed under the BSD-style license found in the
# LICENSE file in the root directory of this source tree.

require 'gutdata/commands/scaffold'

describe GutData::Command::Scaffold do
  before(:all) do
    @suffix = Time.now.strftime('%Y%m%d%H%M%S')
  end

  before(:each) do
    @client = ConnectionHelper.create_default_connection
  end

  after(:each) do
    @client.disconnect
  end

  it "Is Possible to create GutData::Command::Scaffold instance" do
    cmd = GutData::Command::Scaffold.new()
    cmd.should be_a(GutData::Command::Scaffold)
  end

  describe "#brick" do
    before(:each) do
      @brick_name = "test_brick_#{@suffix}"
    end

    after(:each) do
      FileUtils.rm_rf @brick_name
    end

    it "Throws ArgumentError exception if no name specified" do
      expect do
        GutData::Command::Scaffold.brick(nil)
      end.to raise_exception
    end

    it "Scaffolds new brick" do
      GutData::Command::Scaffold.brick(@brick_name)
    end
  end

  describe "#project" do
    before(:each) do
      @project_name = "test_project_#{@suffix}"
    end

    after(:each) do
      FileUtils.rm_rf @project_name
    end

    it "Throws ArgumentError exception if no name specified" do
      expect do
        GutData::Command::Scaffold.project(nil)
      end.to raise_exception
    end

    it "Scaffolds new project" do
      GutData::Command::Scaffold.project(@project_name)
    end
  end

end