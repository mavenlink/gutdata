# encoding: UTF-8
#
# Copyright (c) 2010-2015 GoodData Corporation. All rights reserved.
# This source code is licensed under the BSD-style license found in the
# LICENSE file in the root directory of this source tree.

# Global requires
require 'multi_json'

# Local requires
require 'gutdata/models/models'

require_relative '../environment/environment'

GutData::Environment.load

module GutData::Helpers
  module ProjectHelper
    include GutData::Environment::ProjectHelper

    ENVIRONMENT = 'TESTING'

    class << self
      def get_default_project(opts = {:client => GutData.connection})
        GutData::Project[GutData::Helpers::ProjectHelper::PROJECT_ID, opts]
      end

      def delete_old_projects(opts = {:client => GutData.connection})
        projects = opts[:client].projects
        projects.each do |project|
          next if project.json['project']['meta']['author'] != client.user.uri
          next if project.pid == 'we1vvh4il93r0927r809i3agif50d7iz'
          begin
            puts "Deleting project #{project.title}"
            project.delete
          rescue e
            puts 'ERROR: ' + e.to_s
          end
        end
      end

      def create_random_user(client)
        num = rand(1e7)
        login = "gemtest#{num}@gooddata.com"

        opts = {
          email: login,
          login: login,
          first_name: 'the',
          last_name: num.to_s,
          role: 'editor',
          password: CryptoHelper.generate_password,
          domain: ConnectionHelper::DEFAULT_DOMAIN
        }
        GutData::Membership.create(opts, client: client)
      end
    end
  end
end
