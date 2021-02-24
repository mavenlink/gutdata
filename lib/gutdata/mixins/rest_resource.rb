# encoding: UTF-8
#
# Copyright (c) 2010-2015 GutData Corporation. All rights reserved.
# This source code is licensed under the BSD-style license found in the
# LICENSE file in the root directory of this source tree.

require_relative 'mixins'

module GutData
  module Mixin
    module RestResource
      def self.included(base)
        # Core REST Object Stuff
        base.extend GutData::Mixin::RootKeySetter
        base.send :include, GutData::Mixin::RootKeyGetter
        base.send :include, GutData::Mixin::DataGetter
        base.send :include, GutData::Mixin::MetaGetter
        base.send :include, GutData::Mixin::ObjId
        base.send :include, GutData::Mixin::ContentGetter
        base.send :include, GutData::Mixin::Timestamps
        base.send :include, GutData::Mixin::Links

        base.extend GutData::Mixin::DataPropertyReader
        base.extend GutData::Mixin::DataPropertyWriter
        base.extend GutData::Mixin::MetaPropertyReader
        base.extend GutData::Mixin::MetaPropertyWriter

        # MdObject Stuff
        base.send :include, GutData::Mixin::MdJson
        base.send :include, GutData::Mixin::NotAttribute
        base.send :include, GutData::Mixin::NotExportable
        base.send :include, GutData::Mixin::NotFact
        base.send :include, GutData::Mixin::NotUserGroup
        base.send :include, GutData::Mixin::NotMetric
        base.send :include, GutData::Mixin::NotLabel
        base.send :include, GutData::Mixin::MdRelations
        base.send :include, GutData::Mixin::Author

        base.extend GutData::Mixin::MdObjId
        base.extend GutData::Mixin::MdObjectQuery
        base.extend GutData::Mixin::MdObjectIndexer
        base.extend GutData::Mixin::MdFinders
        base.extend GutData::Mixin::MdIdToUri
      end
    end
  end
end
