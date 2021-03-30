# encoding: UTF-8
#
# Copyright (c) 2010-2015 GoodData Corporation. All rights reserved.
# This source code is licensed under the BSD-style license found in the
# LICENSE file in the root directory of this source tree.

require 'gutdata/models/domain'
require 'gutdata/models/membership'
require 'gutdata/models/project_role'

describe GutData::Membership do
  before(:all) do
    @client = ConnectionHelper.create_default_connection

    @users = [
      @client.create(GutData::Membership,
        {
          'user' => {
            'content' => {
              'email' => 'petr.cvengros@gooddata.com',
              'firstname' => 'Petr',
              'lastname' => 'Cvengros'
            },
            'meta' => {}
          }
        }
      ),

      GutData::Membership.new(
        {
          'user' => {
            'content' => {
              'email' => 'tomas.korcak@gooddata.com',
              'firstname' => 'Tomas',
              'lastname' => 'Korcak'
            },
            'meta' => {}
          }
        }
      ),

      @client.create(GutData::Membership,
        {
          'user' => {
            'content' => {
              'email' => 'patrick.mcconlogue@gooddata.com',
              'firstname' => 'Patrick',
              'lastname' => 'McConlogue'
            },
            'meta' => {}
          }
        }
      ),

      @client.create(GutData::Membership,
        {
          'user' => {
            'content' => {
              'email' => 'tomas.svarovsky@gooddata.com',
              'firstname' => 'Tomas',
              'lastname' => 'Svarovsky'
            },
            'meta' => {}
          }
        }
      ),
    ]
  end

  after(:all) do
    @client.disconnect
  end

  describe '#diff_list' do
    it 'Returns empty diff for same arrays' do
      l1 = [
        @users[0]
      ]

      l2 = [
        @users[0]
      ]

      diff = GutData::Membership.diff_list(l1, l2)
      diff[:added].length.should eql(0)
      diff[:changed].length.should eql(0)
      diff[:removed].length.should eql(0)
    end

    it 'Recognizes added element' do
      l1 = []

      l2 = [
        @users[0]
      ]

      diff = GutData::Membership.diff_list(l1, l2)
      diff[:added].length.should eql(1)
      diff[:changed].length.should eql(0)
      diff[:removed].length.should eql(0)
    end

    it 'Recognizes changed element' do
      l1 = [
        @users[0]
      ]

      l2 = [
        GutData::Membership.new(GutData::Helpers.deep_dup(@users[0].json))
      ]
      l2[0].first_name = 'Peter'

      diff = GutData::Membership.diff_list(l1, l2)
      diff[:added].length.should eql(0)
      diff[:changed].length.should eql(1)
      diff[:removed].length.should eql(0)
    end

    it 'Recognizes removed element' do
      l1 = [
        @users[0]
      ]

      l2 = []

      diff = GutData::Membership.diff_list(l1, l2)
      diff[:added].length.should eql(0)
      diff[:changed].length.should eql(0)
      diff[:removed].length.should eql(1)
    end
  end
end
