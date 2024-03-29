# encoding: UTF-8
#
# Copyright (c) 2010-2015 GoodData Corporation. All rights reserved.
# This source code is licensed under the BSD-style license found in the
# LICENSE file in the root directory of this source tree.

module GutData
  class MalformedUserError < RuntimeError
    DEFAULT_MSG = 'User is malformed'

    def initialize(msg = DEFAULT_MSG)
      super(msg)
    end
  end
end
