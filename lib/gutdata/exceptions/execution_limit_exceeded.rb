# encoding: UTF-8
#
# Copyright (c) 2010-2015 GutData Corporation. All rights reserved.
# This source code is licensed under the BSD-style license found in the
# LICENSE file in the root directory of this source tree.

module GutData
  class ExecutionLimitExceeded < RuntimeError
    def initialize(msg = 'The time limit #{time_limit} secs for polling on #{link} is over')
      super(msg)
    end
  end
end
