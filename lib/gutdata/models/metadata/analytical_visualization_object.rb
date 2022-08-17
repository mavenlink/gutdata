# encoding: UTF-8
# frozen_string_literal: true
#
# Copyright (c) 2010-2021 GoodData Corporation. All rights reserved.
# This source code is licensed under the BSD-style license found in the
# LICENSE file in the root directory of this source tree.

# Backported from https://github.com/gooddata/gooddata-ruby/blob/6153ef930e089a3e7c98af63075d193884916070

module GutData
  class AnalyticalVisualizationObject < GutData::MdObject
    include Mixin::Lockable

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

    # Locks an object with all used objects. The types of objects that are affected by locks
    # are analytical dashboards, visualization objects, and metrics. This means that if you lock a
    # dashboard by this method all used visualization objects and metrics are also locked. If you
    # lock a visualization object all used metrics are also locked. The current object is reloaded.
    # This means that the #locked? will return true.
    #
    # @return [GutData::Mixin::Lockable]
    def lock_with_dependencies!
      using('visualizationObject').pmap { |link| project.visualization_objects(link['link']) }.reject(&:locked?).pmap(&:lock!)
      using('analyticalDashboard').pmap { |link| project.analytical_dashboards(link['link']) }.reject(&:locked?).pmap(&:lock!)
      using('metric').pmap { |link| project.metrics(link['link']) }.reject(&:locked?).pmap(&:lock!)
      lock!
    end

    # Unlocks an object with all used objects. The types of objects that are affected by locks
    # are  analytical dashboards, visualization objects, and metrics. This means that if you unlock a
    # dashboard by this method all used visualization objects and metrics are also unlocked. If you
    # unlock a visualization objects all used metrics are also unlocked. The current object is unlocked
    # as well. Beware that certain objects might be in use in multiple contexts. For example one metric
    # can be used in several visualization objects. This method performs no checks to determine if an
    # object should stay locked or not.
    #
    # @return [GutData::Mixin::Lockable]
    def unlock_with_dependencies!
      using('visualizationObject').pmap { |link| project.visualization_objects(link['link']) }.select(&:locked?).pmap(&:unlock!)
      using('analyticalDashboard').pmap { |link| project.analytical_dashboards(link['link']) }.select(&:locked?).pmap(&:unlock!)
      using('metric').pmap { |link| project.metrics(link['link']) }.select(&:locked?).pmap(&:unlock!)
      unlock!
    end
  end
end
