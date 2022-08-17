# encoding: UTF-8
# frozen_string_literal: true
#
# Copyright (c) 2010-2021 GutData Corporation. All rights reserved.
# This source code is licensed under the BSD-style license found in the
# LICENSE file in the root directory of this source tree.

# Backported from https://github.com/gooddata/gooddata-ruby/blob/6153ef930e089a3e7c98af63075d193884916070

require_relative 'analytical_visualization_object'

module GutData
  class VisualizationObject < GutData::AnalyticalVisualizationObject
    EMPTY_OBJECT = {
      'visualizationObject' => {
        'content' => {
          'buckets' => [],
          'properties' => '',
          'visualizationClass' => {}
        },
        'links' => {},
        'meta' => {
          'deprecated' => '0',
          'summary' => '',
          'title' => ''
        }
      }
    }

    ASSIGNABLE_MEMBERS = %i[buckets properties visualizationClass deprecated summary title]

    class << self
      # Method intended to get all VisualizationObject objects in a specified project
      #
      # @param options [Hash] the options hash
      # @option options [Boolean] :full with true value to pull full objects
      # @return [Array<GutData::VisualizationObject>] Return VisualizationObject list
      def all(options = { :client => GutData.connection, :project => GutData.project })
        query('visualizationObject', VisualizationObject, options)
      end

      # Create Visualization Object in the specify project
      #
      # @param visualization_object [Hash] the data of object will be created
      # @param options [Hash] The project that the object will be created in
      # @return GutData::VisualizationObject object
      def create(visualization_object = {}, options = { :client => GutData.client, :project => GutData.project })
        GutData::AnalyticalVisualizationObject.create(visualization_object, VisualizationObject, EMPTY_OBJECT, ASSIGNABLE_MEMBERS, options)
      end
    end
  end
end
