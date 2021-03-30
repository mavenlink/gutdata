# encoding: UTF-8
#
# Copyright (c) 2010-2015 GoodData Corporation. All rights reserved.
# This source code is licensed under the BSD-style license found in the
# LICENSE file in the root directory of this source tree.

require 'highline'

require 'gutdata/cli/terminal'
require 'gutdata/commands/auth'
require 'gutdata/helpers/auth_helpers'

describe GutData::Command::Auth do
  ORIG_TERMINAL = GutData::CLI::DEFAULT_TERMINAL unless const_defined?(:ORIG_TERMINAL)

  DEFAULT_CREDENTIALS = {
    :email => 'joedoe@example.com',
    :password => 'secretPassword',
    :token => 't0k3n1sk0',
    :environment => 'DEVELOPMENT',
    :server => 'https://secure.gooddata.com'
  }

  DEFAULT_CREDENTIALS_OVER = {
    :email => 'pepa@depo.com',
    :password => 'lokomotiva',
    :token => 'briketa',
  }

  DEFAULT_CREDENTIALS_TEMP_FILE_NAME = 'credentials'

  before(:all) do
    @input = StringIO.new
    @output = StringIO.new
    @terminal = HighLine.new(@input, @output)

    GutData::CLI::DEFAULT_TERMINAL = @terminal
  end

  after(:all) do
    GutData::CLI::DEFAULT_TERMINAL = ORIG_TERMINAL
  end


  before(:each) do
    @client = ConnectionHelper::create_default_connection
  end

  after(:each) do
    @client.disconnect
  end

  it "Is Possible to create GutData::Command::Auth instance" do
    cmd = GutData::Command::Auth.new()
    cmd.should be_a(GutData::Command::Auth)
  end

  describe "#credentials_file" do
    it "Returns credentials_file" do
      GutData::Helpers::AuthHelper.credentials_file
    end
  end

  describe "#ask_for_credentials" do
    it 'Interactively asks user for crendentials' do
      @input.string = ''
      @input << DEFAULT_CREDENTIALS[:email] << "\n"
      @input << DEFAULT_CREDENTIALS[:password] << "\n"
      @input << DEFAULT_CREDENTIALS[:token] << "\n"
      @input << DEFAULT_CREDENTIALS[:environment] << "\n"
      @input << DEFAULT_CREDENTIALS[:server] << "\n"
      @input.rewind

      GutData::Command::Auth.ask_for_credentials
    end
  end

  describe "#read_credentials" do
    it 'Reads credentials from default file if no path specified' do
      GutData::Helpers::AuthHelper.read_credentials
    end

    it 'Reads credentials from file specified' do
      temp_path = Tempfile.new(DEFAULT_CREDENTIALS_TEMP_FILE_NAME).path

      result = GutData::Helpers::AuthHelper.write_credentials(DEFAULT_CREDENTIALS, temp_path)

      GutData::Helpers::AuthHelper.read_credentials(temp_path)
      GutData::Command::Auth.unstore(temp_path)

      result.should == DEFAULT_CREDENTIALS
    end

    it 'Returns empty hash if invalid path specified' do
      expect = {}
      result = GutData::Helpers::AuthHelper.read_credentials('/some/invalid/path')
      result.should == expect
    end
  end

  describe "#write_credentials" do
    it 'Writes credentials' do
      temp_path = Tempfile.new(DEFAULT_CREDENTIALS_TEMP_FILE_NAME).path

      result = GutData::Helpers::AuthHelper.write_credentials(DEFAULT_CREDENTIALS, temp_path)
      GutData::Command::Auth.unstore(temp_path)

      result.should == DEFAULT_CREDENTIALS
    end
  end

  describe "#store" do
    it 'Stores credentials' do
      @input.string = ''
      @input << DEFAULT_CREDENTIALS[:email] << "\n"
      @input << DEFAULT_CREDENTIALS[:password] << "\n"
      @input << DEFAULT_CREDENTIALS[:token] << "\n"
      @input << DEFAULT_CREDENTIALS[:environment] << "\n"
      @input << DEFAULT_CREDENTIALS[:server] << "\n"
      @input << 'y' << "\n"
      @input.rewind

      temp_path = Tempfile.new(DEFAULT_CREDENTIALS_TEMP_FILE_NAME).path
      GutData::Command::Auth.unstore(temp_path)
      GutData::Command::Auth.store(temp_path)
    end

    it 'Overwrites credentials if confirmed' do
      @input.string = ''
      @input << DEFAULT_CREDENTIALS[:email] << "\n"
      @input << DEFAULT_CREDENTIALS[:password] << "\n"
      @input << DEFAULT_CREDENTIALS[:token] << "\n"
      @input << DEFAULT_CREDENTIALS[:environment] << "\n"
      @input << DEFAULT_CREDENTIALS[:server] << "\n"
      @input << 'y' << "\n"
      @input.rewind

      temp_path = Tempfile.new(DEFAULT_CREDENTIALS_TEMP_FILE_NAME).path
      GutData::Helpers::AuthHelper.write_credentials(DEFAULT_CREDENTIALS, temp_path)

      GutData::Command::Auth.store(temp_path)
    end

    it 'Do not overwrites credentials if not confirmed' do
      @input.string = ''
      @input << DEFAULT_CREDENTIALS_OVER[:email] << "\n"
      @input << DEFAULT_CREDENTIALS_OVER[:password] << "\n"
      @input << DEFAULT_CREDENTIALS_OVER[:token] << "\n"
      @input << DEFAULT_CREDENTIALS[:environment] << "\n"
      @input << DEFAULT_CREDENTIALS[:server] << "\n"
      @input << 'n' << "\n"
      @input.rewind

      temp_path = Tempfile.new(DEFAULT_CREDENTIALS_TEMP_FILE_NAME).path
      GutData::Helpers::AuthHelper.write_credentials(DEFAULT_CREDENTIALS, temp_path)

      GutData::Command::Auth.store(temp_path)
      result = GutData::Helpers::AuthHelper.read_credentials(temp_path)

      result.should == DEFAULT_CREDENTIALS
    end
  end

  describe "#unstore" do
    it 'Removes stored credentials' do
      temp_path = Tempfile.new(DEFAULT_CREDENTIALS_TEMP_FILE_NAME).path
      GutData::Helpers::AuthHelper.write_credentials(DEFAULT_CREDENTIALS, temp_path)
      GutData::Command::Auth.unstore(temp_path)
    end
  end
end