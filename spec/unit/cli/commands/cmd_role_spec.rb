# encoding: UTF-8
#
# Copyright (c) 2010-2015 GoodData Corporation. All rights reserved.
# This source code is licensed under the BSD-style license found in the
# LICENSE file in the root directory of this source tree.

require 'gutdata/cli/cli'

describe GutData::CLI, :broken => true do
  describe 'role' do
    it 'Complains when no parameters specified' do
      args = %w(role)

      out = run_cli(args)
      out.should include "Command 'role' requires a subcommand list"
    end

    describe 'role list' do
      it 'Complains when no project ID specified' do
        args = [
          '-U',
          ConnectionHelper::DEFAULT_USERNAME,
          '-P',
          ConnectionHelper::DEFAULT_PASSWORD,
          'role',
          'list'
        ]

        out = run_cli(args)
        out.should include 'Project ID has to be provided'
      end

      it 'List roles when passing project ID' do
        pending 'Investignate which project to use'

        args = [
          '-U',
          ConnectionHelper::DEFAULT_USERNAME,
          '-P',
          ConnectionHelper::DEFAULT_PASSWORD,
          '-p',
          ProjectHelper::PROJECT_ID,
          'role',
          'list',
        ]

        out = run_cli(args)

        expected_roles = [
          'adminRole,/gdc/projects/tk6192gsnav58crp6o1ahsmtuniq8khb/roles/2'
        ]

        expected_roles.each do |expected_role|
          out.should include expected_role
        end
      end
    end
  end
end