# encoding: UTF-8
#
# Copyright (c) 2010-2015 GoodData Corporation. All rights reserved.
# This source code is licensed under the BSD-style license found in the
# LICENSE file in the root directory of this source tree.

module GutData
  module Mixin
    module NotLabel
      # Returns true if the object is a fact label otherwise
      # @return [Boolean]
      def label?
        false
      end

      alias_method :display_form?, :label?
    end
  end
end
