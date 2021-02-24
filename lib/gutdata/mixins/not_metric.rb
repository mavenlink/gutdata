# encoding: UTF-8
#
# Copyright (c) 2010-2015 GutData Corporation. All rights reserved.
# This source code is licensed under the BSD-style license found in the
# LICENSE file in the root directory of this source tree.

module GutData
  module Mixin
    module NotMetric
      # Returns true if the object is a metric false otherwise
      # @return [Boolean]
      def metric?
        false
      end

      alias_method :measure?, :metric?
    end
  end
end
