# encoding: UTF-8
#
# Copyright (c) 2010-2015 GoodData Corporation. All rights reserved.
# This source code is licensed under the BSD-style license found in the
# LICENSE file in the root directory of this source tree.

require_relative '../rest/rest'

module GutData
  class Invitation < Rest::Resource
    def initialize(json)
      @json = json
    end

    def contributor
      data = client.get @json['invitation']['meta']['contributor']
      client.create GutData::AccountSettings, data
    end

    def created
      DateTime.parse(@json['invitation']['meta']['created'])
    end

    def email
      @json['invitation']['content']['email']
    end

    def first_name
      @json['invitation']['content']['firstname']
    end

    def phone
      @json['invitation']['content']['phone']
    end

    def profile
      data = client.get @json['invitation']['links']['profile']
      client.create GutData::AccountSettings, data
    end

    def project
      data = client.get @json['invitation']['links']['project']
      client.create GutData::Project, data
    end

    def project_name
      @json['invitation']['content']['projectname']
    end

    def role
      # TODO: Return object instead
      @json['invitation']['content']['role']
    end

    def status
      @json['invitation']['content']['status']
    end

    def summary
      @json['invitation']['content']['summary']
    end

    def title
      @json['invitation']['content']['title']
    end

    def updated
      DateTime.parse(@json['invitation']['meta']['updated'])
    end

    def uri
      @json['invitation']['links']['self']
    end
  end
end
