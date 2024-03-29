# encoding: UTF-8
#
# Copyright (c) 2010-2015 GoodData Corporation. All rights reserved.
# This source code is licensed under the BSD-style license found in the
# LICENSE file in the root directory of this source tree.

require 'gutdata/commands/datawarehouse'

describe GutData::Command::DataWarehouse do
  before(:each) do
    @client = ConnectionHelper.create_default_connection
  end

  after(:each) do
    @client.disconnect
  end

  it "Is Possible to create GutData::Command::DataWarehouse instance" do
    cmd = GutData::Command::DataWarehouse.new()
    cmd.should be_a(GutData::Command::DataWarehouse)
  end

  it "Can create a data warehouse" do
    title = 'my warehouse'
    summary = 'hahahaha'
    dwh = nil

    begin
      dwh = GutData::Command::DataWarehouse.create(title: title, summary: summary, token: ConnectionHelper::GD_PROJECT_TOKEN, environment: ProjectHelper::ENVIRONMENT, client: @client)

      expect(dwh.title).to eq(title)
      expect(dwh.summary).to eq(summary)
      expect(dwh.id).not_to be_nil
      expect(dwh.status).to eq('ENABLED')
    ensure
      dwh.delete if dwh
    end
  end
end