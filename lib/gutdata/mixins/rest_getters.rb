# encoding: UTF-8
#
# Copyright (c) 2010-2015 GutData Corporation. All rights reserved.
# This source code is licensed under the BSD-style license found in the
# LICENSE file in the root directory of this source tree.

require_relative 'data_getter'
require_relative 'meta_getter'

module GutData
  module Mixin
    module RestGetters
      include Mixin::MetaGetter
      include Mixin::DataGetter
    end
  end
end
