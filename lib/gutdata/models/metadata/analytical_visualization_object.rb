# encoding: UTF-8
# frozen_string_literal: true
#
# Copyright (c) 2010-2021 GoodData Corporation. All rights reserved.
# This source code is licensed under the BSD-style license found in the
# LICENSE file in the root directory of this source tree.

# Backported from https://github.com/gooddata/gooddata-ruby/blob/6153ef930e089a3e7c98af63075d193884916070/lib/gooddata/models/metadata/analytical_visualization_object.rb

module GoodData
  class AnalyticalVisualizationObject < GutData::MdObject
    class << self
      # Create a specify object in the specify project
      #
      # @param object_data [Hash] the data of object will be created
      # @param klass [Class] A class used for instantiating the returned data
      # @param empty_data_object [Hash] the empty data of object will be created
      # @param assignable_properties [Hash] the properties allow updating
      # @param options [Hash] The project that the object will be created in
      # @return klass object
      def create(object_data, klass, empty_data_object = {}, assignable_properties = [], options = { :client => GutData.client, :project => GutData.project })
        client, project = GutData.get_client_and_project(GutData::Helpers.symbolize_keys(options))

        res = client.create(klass, GutData::Helpers.deep_dup(GutData::Helpers.stringify_keys(empty_data_object)), :project => project)
        object_data.each do |k, v|
          res.send("#{k}=", v) if assignable_properties.include? k
        end
        res
      end
    end
  end
end
