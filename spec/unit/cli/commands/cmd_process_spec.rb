# encoding: UTF-8
#
# Copyright (c) 2010-2015 GoodData Corporation. All rights reserved.
# This source code is licensed under the BSD-style license found in the
# LICENSE file in the root directory of this source tree.

require 'gutdata/cli/cli'

describe 'GutData::CLI - process', :broken => true do
  describe 'process' do
    it 'Complains when no subcommand specified' do
      args = %w(process)

      out = run_cli(args)
      out.should include "Command 'process' requires a subcommand list,show,deploy,delete,execute"
    end
  end

  describe 'process deploy' do
    it 'Can be called without arguments' do
      args = %w(process deploy)

      run_cli(args)
    end
  end

  describe 'process get' do
    it 'Can be called without arguments' do
      args = %w(process get)

      run_cli(args)
    end
  end

  describe 'process list' do
    it 'Lists processes when project ID specified' do
      args = [
        'process',
        'list',
        ProjectHelper::PROJECT_ID
      ]

      run_cli(args)
    end
  end

end