# encoding: UTF-8
#
# Copyright (c) 2010-2015 GutData Corporation. All rights reserved.
# This source code is licensed under the BSD-style license found in the
# LICENSE file in the root directory of this source tree.

require 'highline/import'
require 'multi_json'

require_relative '../core/core'

module GutData
  module Command
    class User
      class << self
        def roles(pid)
          roles_response = GutData.get("/gdc/projects/#{pid}/roles")

          roles = {}
          roles_response['projectRoles']['roles'].each do |role_uri|
            r = GutData.get(role_uri)
            identifier = r['projectRole']['meta']['identifier']
            roles[identifier] = {
              :user_uri => r['projectRole']['links']['roleUsers'],
              :uri => role_uri
            }
          end
          roles
        end

        def show(opts = { client: GutData.connection })
          client = opts[:client]
          fail ArgumentError, 'No :client specified' if client.nil?
          pp client.user.json
        end
      end
    end
  end
end
