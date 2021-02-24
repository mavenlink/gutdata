# encoding: UTF-8
#
# Copyright (c) 2010-2015 GutData Corporation. All rights reserved.
# This source code is licensed under the BSD-style license found in the
# LICENSE file in the root directory of this source tree.

require_relative '../exceptions/command_failed'
require_relative '../models/domain'

module GutData
  module Command
    # Low level access to GutData API
    class Domain
      attr_reader :name

      class << self
        def add_user(domain, login, password, opts = { :client => GutData.connection })
          data = {
            :domain => domain,
            :login => login,
            :password => password
          }
          GutData::Domain.add_user(data.merge(opts))
        end

        def list_users(domain, opts = { :client => GutData.connection })
          GutData::Domain.users(domain, opts)
        end
      end
    end
  end
end
