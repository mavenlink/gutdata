# encoding: UTF-8
#
# Copyright (c) 2010-2015 GutData Corporation. All rights reserved.
# This source code is licensed under the BSD-style license found in the
# LICENSE file in the root directory of this source tree.

require_relative '../metadata'
require_relative '../../mixins/is_dimension'
require_relative 'metadata'

module GutData
  class Dimension < GutData::MdObject
    include Mixin::IsDimension

    class << self
      # Method intended to get all objects of that type in a specified project
      #
      # @param options [Hash] the options hash
      # @option options [Boolean] :full if passed true the subclass can decide to pull in full objects. This is desirable from the usability POV but unfortunately has negative impact on performance so it is not the default
      # @return [Array<GutData::MdObject> | Array<Hash>] Return the appropriate metadata objects or their representation
      def all(options = { :client => GutData.connection, :project => GutData.project })
        query('dimension', Dimension, options)
      end

      # Returns a Project object identified by given string
      # The following identifiers are accepted
      #  - /gdc/md/<id>
      #  - /gdc/projects/<id>
      #  - <id>
      #
      def [](id, opts = { client: GutData.connection })
        return id if id.instance_of?(GutData::Dimension) || id.respond_to?(:dimension?) && id.dimension?

        if id == :all
          Dimension.all({ client: GutData.connection }.merge(opts))
        else
          uri = id

          c = client(opts)
          fail ArgumentError, 'No :client specified' if c.nil?

          response = c.get(uri)
          c.factory.create(Dimension, response)
        end
      end
    end

    def attributes
      content['attributes'].map do |attribute|
        client.create(Attribute, { 'attribute' => attribute }, project: project)
      end
    end
  end
end
