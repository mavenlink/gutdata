# encoding: UTF-8
#
# Copyright (c) 2010-2015 GoodData Corporation. All rights reserved.
# This source code is licensed under the BSD-style license found in the
# LICENSE file in the root directory of this source tree.

require_relative '../../goodzilla/goodzilla'
require_relative '../../mixins/mixins'
require_relative '../metadata'
require_relative 'metadata'

module GutData
  # Metric representation
  class Metric < MdObject
    include Mixin::Lockable

    class << self
      # Method intended to get all objects of that type in a specified project
      #
      # @param options [Hash] the options hash
      # @option options [Boolean] :full if passed true the subclass can decide to pull in full objects. This is desirable from the usability POV but unfortunately has negative impact on performance so it is not the default
      # @return [Array<GutData::MdObject> | Array<Hash>] Return the appropriate metadata objects or their representation
      def all(options = { :client => GutData.connection, :project => GutData.project })
        query('metric', Metric, options)
      end

      def xcreate(metric, options = { :client => GutData.connection, :project => GutData.project })
        create(metric, { extended_notation: true }.merge(options))
      end

      def create(metric, options = { :client => GutData.connection, :project => GutData.project })
        client, project = GutData.get_client_and_project(options)

        if metric.is_a?(String)
          expression = metric || options[:expression]
          extended_notation = options[:extended_notation] || false
          title = options[:title]
          summary = options[:summary]
        else
          metric ||= options
          title = metric[:title] || options[:title]
          summary = metric[:summary] || options[:summary]
          expression = metric[:expression] || options[:expression] || fail('Metric has to have its expression defined')
          extended_notation = metric[:extended_notation] || options[:extended_notation] || false
        end

        expression = if extended_notation
                       dict = {
                         :facts => project.facts.reduce({}) do |memo, item|
                           memo[item.title] = item.uri
                           memo
                         end,
                         :attributes => project.attributes.reduce({}) do |memo, item|
                           memo[item.title] = item.uri
                           memo
                         end,
                         :metrics => project.metrics.reduce({}) do |memo, item|
                           memo[item.title] = item.uri
                           memo
                         end
                       }
                       interpolated_metric = GutData::SmallGoodZilla.interpolate_metric(expression, dict, options)
                       interpolated_metric
                     else
                       expression
                     end

        metric = {
          'metric' => {
            'content' => {
              'format' => '#,##0',
              'expression' => expression
            },
            'meta' => {
              'tags' => '',
              'summary' => summary,
              'title' => title
            }
          }
        }
        # TODO: add test for explicitly provided identifier
        metric['metric']['meta']['identifier'] = options[:identifier] if options[:identifier]

        client.create(Metric, metric, :project => project)
      end

      def execute(expression, options = { :client => GutData.connection })
        # client = options[:client]
        # fail ArgumentError, 'No :client specified' if client.nil?

        options = expression if expression.is_a?(Hash)

        m = if expression.is_a?(String)
              tmp = {
                :title => 'Temporary metric to be deleted',
                :expression => expression
              }.merge(options)

              GutData::Metric.create(tmp, options)
            else
              tmp = {
                :title => 'Temporary metric to be deleted'
              }.merge(expression)
              GutData::Metric.create(tmp, options)
            end
        m.execute
      end

      def xexecute(expression, opts = { :client => GutData.connection, :project => GutData.project })
        GutData.get_client_and_project(opts)

        execute(expression, opts.merge(:extended_notation => true))
      end
    end

    def execute
      opts = {
        :client => client,
        :project => project
      }
      res = GutData::ReportDefinition.execute(opts.merge(:left => self))
      res.data[0][0] if res && !res.empty?
    end

    def expression
      content['expression']
    end

    def expression=(value)
      content['expression'] = value
    end

    def validate
      fail 'Metric needs to have title' if title.nil?
      true
    end

    def metric?
      true
    end

    # Checks that the expression contains certain metadata object. The difference between this and used_by using is in the fact that this is not a transitive closure. it searches only inside the expression
    # @param [GutData::MdObject] item Object that is going to be looked up
    # @return [Boolean]
    def contain?(item)
      uri = item.respond_to?(:uri) ? item.uri : item
      expression[uri] != nil
    end

    # Checks that the expression contains certain element of an attribute. The value is looked up through given label.
    # @param [GutData::Label] label Label though which the value is looked up
    # @param [String] value Value that will be looked up through the label.
    # @return [Boolean]
    def contain_value?(label, value)
      uri = label.find_value_uri(value)
      contain?(uri)
    end

    # Method used for replacing values in their state according to mapping. Can be used to replace any values but it is typically used to replace the URIs. Returns a new object of the same type.
    #
    # @param [Array<Array>]Mapping specifying what should be exchanged for what. As mapping should be used output of GutData::Helpers.prepare_mapping.
    # @return [GutData::Metric]
    def replace(mapping)
      x = GutData::MdObject.replace_quoted(self, mapping)
      x = GutData::MdObject.replace_bracketed(x, mapping)
      vals = GutData::MdObject.find_replaceable_values(x, mapping)
      GutData::MdObject.replace_bracketed(x, vals)
    end

    # Method used for replacing attribute element values. Looks up certain value of a label in the MAQL expression and exchanges it for a different value of the same label.
    # @param [GutData::Label] label Label through which the value and for_value are resolved
    # @param [String] value value that is going to be replaced
    # @param [String] for_value value that is going to be the new one
    # @return [GutData::Metric]
    def replace_value(label, value, for_label, for_value = nil)
      label = label.respond_to?(:primary_label) ? label.primary_label : label
      if for_value
        for_label = for_label.respond_to?(:primary_label) ? for_label.primary_label : for_label
        value_uri = label.find_value_uri(value)
        for_value_uri = for_label.find_value_uri(for_value)
        self.expression = expression.gsub(value_uri, for_value_uri)
        self.expression = expression.gsub(label.attribute.uri, for_label.attribute.uri)
      else
        for_value = for_label
        value_uri = label.find_value_uri(value)
        for_value_uri = label.find_value_uri(for_value)
        self.expression = expression.gsub(value_uri, for_value_uri)
      end
      self
    end

    # Looks up the readable values of the objects used inside of MAQL epxpressions. Labels and elements titles are based on the primary label.
    # @return [String] Ther resulting MAQL like expression
    def pretty_expression
      SmallGoodZilla.pretty_print(expression, client: client, project: project)
    end
  end
end
