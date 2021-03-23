# encoding: UTF-8
#
# Copyright (c) 2010-2015 GoodData Corporation. All rights reserved.
# This source code is licensed under the BSD-style license found in the
# LICENSE file in the root directory of this source tree.

require_relative '../metadata'

module GutData
  class Dataset < MdObject
    class << self
      # Method intended to get all objects of that type in a specified project
      #
      # @param options [Hash] the options hash
      # @option options [Boolean] :full if passed true the subclass can decide to pull in full objects. This is desirable from the usability POV but unfortunately has negative impact on performance so it is not the default
      # @return [Array<GutData::MdObject> | Array<Hash>] Return the appropriate metadata objects or their representation
      def all(options = { :client => GutData.connection, :project => GutData.project })
        query('dataSet', Dataset, options)
      end
    end

    # Gives you list of attributes on a dataset
    #
    # @return [Array<GutData::Attribute>]
    def attributes
      attribute_uris.pmap { |a_uri| project.attributes(a_uri) }
    end

    # Gives you list of attribute uris on a dataset
    #
    # @return [Array<String>]
    def attribute_uris
      content['attributes']
    end

    # Gives you list of facts on a dataset
    #
    # @return [Array<GutData::Fact>]
    def facts
      fact_uris.pmap { |a_uri| project.facts(a_uri) }
    end

    # Gives you list of fact uris on a dataset
    #
    # @return [Array<String>]
    def fact_uris
      content['facts']
    end

    # Tells you if a dataset is a date dimension. This is done by looking at
    # the attributes and inspecting their identifiers.
    #
    # @return [Boolean]
    def date_dimension?
      attributes.all?(&:date_attribute?) && fact_uris.empty?
    end

    # Delete the data in a dataset
    def synchronize
      project.execute_maql("SYNCHRONIZE {#{identifier}}")
    end
    alias_method :delete_data, :synchronize
  end
end
