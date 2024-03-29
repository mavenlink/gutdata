# encoding: UTF-8
#
# Copyright (c) 2010-2015 GoodData Corporation. All rights reserved.
# This source code is licensed under the BSD-style license found in the
# LICENSE file in the root directory of this source tree.

require 'gutdata/connection'

describe GutData::Rest::Connection do
  before(:all) do
    USERNAME = ConnectionHelper::DEFAULT_USERNAME
    PASSWORD = ConnectionHelper::DEFAULT_PASSWORD
  end

  it "Has DEFAULT_URL defined" do
    GutData::Rest::Connection::DEFAULT_URL.should be_a(String)
  end

  it "Has LOGIN_PATH defined" do
    GutData::Rest::Connection::LOGIN_PATH.should be_a(String)
  end

  it "Has TOKEN_PATH defined" do
    GutData::Rest::Connection::TOKEN_PATH.should be_a(String)
  end

  describe '#connect' do
    it "Connects using username and password" do
      c = GutData.connect(ConnectionHelper::DEFAULT_USERNAME, ConnectionHelper::DEFAULT_PASSWORD, :verify_ssl => 0)
      c.should be_a(GutData::Rest::Client)
      c.disconnect
    end
  end

  describe '#disconnect' do
    it "Connects using username and password" do
      c = GutData.connect(ConnectionHelper::DEFAULT_USERNAME, ConnectionHelper::DEFAULT_PASSWORD, :verify_ssl => 0)
      c.disconnect
    end
  end

  describe '#generate_request_id' do
    it "Generates a non-empty string" do
      c = ConnectionHelper.create_default_connection

      # generate a request id, and pass it to a request
      id = c.generate_request_id
      resp = c.get('/gdc/md', :request_id => id)

      id.should be_a(String)
      id.should_not be_empty

      c.disconnect
    end
  end

end