# encoding: UTF-8
#
# Copyright (c) 2010-2015 GutData Corporation. All rights reserved.
# This source code is licensed under the BSD-style license found in the
# LICENSE file in the root directory of this source tree.

require_relative '../shared'
require_relative '../../commands/auth'

module GutData
  module CLI
    desc 'Work with your locally stored credentials'
    command :auth do |c|
      c.desc 'Store your credentials to ~/.gutdata so client does not have to ask you every single time'
      c.command :store do |store|
        store.action do |_global_options, _options, _args|
          GutData::Command::Auth.store
        end
      end

      c.desc 'Clean the credentials'
      c.command :clear do |store|
        store.action do |_global_options, _options, _args|
          GutData::Command::Auth.unstore
        end
      end
    end
  end
end
