# encoding: UTF-8
#
# Copyright (c) 2010-2015 GutData Corporation. All rights reserved.
# This source code is licensed under the BSD-style license found in the
# LICENSE file in the root directory of this source tree.

require 'highline'

# Define GutData::CLI as GLI Wrapper
module GutData
  module CLI
    DEFAULT_TERMINAL = HighLine.new unless const_defined?(:DEFAULT_TERMINAL)

    class << self
      def terminal
        DEFAULT_TERMINAL
      end
    end
  end
end
