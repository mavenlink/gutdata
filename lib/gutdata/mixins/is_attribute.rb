# encoding: UTF-8
#
# Copyright (c) 2010-2015 GoodData Corporation. All rights reserved.
# This source code is licensed under the BSD-style license found in the
# LICENSE file in the root directory of this source tree.

module GutData
  module Mixin
    module IsAttribute
      # Returns true if the object is a attribute false otherwise
      # @return [Boolean]
      def attribute?
        true
      end
    end
  end
end
