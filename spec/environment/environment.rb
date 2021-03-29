# encoding: UTF-8
#
# Copyright (c) 2010-2015 GoodData Corporation. All rights reserved.
# This source code is licensed under the BSD-style license found in the
# LICENSE file in the root directory of this source tree.

module GutData
  module Environment
    class << self
      def load(env = ENV['GD_ENV'] || 'develop')
        require_relative 'default'
        require_relative env

        ENV['GD_SERVER'] = GutData::Environment::ConnectionHelper::DEFAULT_SERVER
      end
    end
  end
end
