# encoding: UTF-8
#
# Copyright (c) 2010-2015 GutData Corporation. All rights reserved.
# This source code is licensed under the BSD-style license found in the
# LICENSE file in the root directory of this source tree.

module GutData
  module Mixin
    module MdObjId
      def uri_obj_id(uri)
        GutData::Helpers.last_uri_part(uri)
      end
    end
  end
end
