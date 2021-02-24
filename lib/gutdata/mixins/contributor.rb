# encoding: UTF-8
#
# Copyright (c) 2010-2015 GutData Corporation. All rights reserved.
# This source code is licensed under the BSD-style license found in the
# LICENSE file in the root directory of this source tree.

module GutData
  module Mixin
    module Contributor
      # Gets Project Role Contributor
      #
      # @return [GutData::Profile] Project Role Contributor
      def contributor
        url = meta['contributor']
        tmp = client.get url
        GutData::Profile.new(tmp)
      end
    end
  end
end
