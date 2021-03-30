# encoding: UTF-8
#
# Copyright (c) 2010-2015 GoodData Corporation. All rights reserved.
# This source code is licensed under the BSD-style license found in the
# LICENSE file in the root directory of this source tree.

require 'gutdata/commands/datasets'

describe GutData::Command::Datasets do
  before(:each) do
    @client = ConnectionHelper::create_default_connection
    @cmd = GutData::Command::Datasets.new()
  end

  after(:each) do
    @client.disconnect
  end

  it "Is Possible to create GutData::Command::Datasets instance" do
    @cmd.should be_a(GutData::Command::Datasets)
  end

  describe "#index" do
    it "Lists all datasets" do
      skip("GutData::Command::Dataset#with_project not working")
      @cmd.index
    end
  end

  describe "#describe" do
    it "Describes dataset" do
      skip("GutData::Command::Dataset#extract_option not working")
      @cmd.describe
    end
  end

  describe "#apply" do
    it "Creates a server-side model" do
      skip("GutData::Command::Dataset#with_project not working")
      @cmd.apply
    end
  end

  describe "#load" do
    it "Loads a CSV file into an existing dataset" do
      skip("GutData::Command::Dataset#with_project not working")
      @cmd.load
    end
  end
end