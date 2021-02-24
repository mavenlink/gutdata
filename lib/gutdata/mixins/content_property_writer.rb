# encoding: UTF-8
#
# Copyright (c) 2010-2015 GutData Corporation. All rights reserved.
# This source code is licensed under the BSD-style license found in the
# LICENSE file in the root directory of this source tree.

module GutData
  module Mixin
    module ContentPropertyWriter
      def content_property_writer(*props)
        props.each do |prop|
          define_method "#{prop}=", proc { |val| content[prop.to_s] = val }
        end
      end
    end
  end
end
