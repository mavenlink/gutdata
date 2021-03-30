# encoding: UTF-8
#
# Copyright (c) 2010-2015 GoodData Corporation. All rights reserved.
# This source code is licensed under the BSD-style license found in the
# LICENSE file in the root directory of this source tree.

require 'gutdata/connection'
require 'gutdata/core/project'
require 'gutdata/models/project'

describe 'GutData - project' do
  before(:each) do
    @client = ConnectionHelper.create_default_connection
  end

  after(:each) do
    @client.disconnect
  end

  describe '#project=' do
    it 'Assigns nil' do
      GutData.project = nil
    end

    it 'Assigns project using project ID' do
      GutData.use(ProjectHelper::PROJECT_ID, client: @client)
    end

    it 'Assigns project using project URL' do
      GutData.use ProjectHelper::PROJECT_URL, client: @client
    end

    it 'Assigns project directly' do
      GutData.project = GutData::Project[ProjectHelper::PROJECT_ID, client: @client]
    end
  end

  describe '#project' do
    it 'Returns project assigned' do
      GutData.project = nil
      GutData.project.should == nil

      GutData.use ProjectHelper::PROJECT_ID, client: @client
      GutData.project.should_not == nil
    end
  end

  describe '#with_project' do
    it 'Uses project specified' do
      GutData.with_project GutData::Project[ProjectHelper::PROJECT_ID, :client => @client] do
      end
    end
  end
end