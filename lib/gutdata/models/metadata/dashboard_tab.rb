# encoding: UTF-8
#
# Copyright (c) 2010-2015 GoodData Corporation. All rights reserved.
# This source code is licensed under the BSD-style license found in the
# LICENSE file in the root directory of this source tree.

require_relative '../../core/core'
require_relative '../../helpers/global_helpers'
require_relative '../metadata'
require_relative 'metadata'
require_relative 'report'

require 'multi_json'

require_relative 'dashboard/filter_item'
require_relative 'dashboard/filter_apply_item'
require_relative 'dashboard/geo_chart_item'
require_relative 'dashboard/headline_item'
require_relative 'dashboard/iframe_item'
require_relative 'dashboard/report_item'
require_relative 'dashboard/text_item'

module GutData
  class DashboardTab
    attr_reader :dashboard
    attr_accessor :json

    EMPTY_OBJECT = {
      :title => '',
      :items => []
    }

    ASSIGNABLE_MEMBERS = [
      :title,
      :items,
      :identifier
    ]

    class << self
      def create(dashboard, tab)
        res = GutData::DashboardTab.new(dashboard, GutData::Helpers.deep_dup(GutData::Helpers.deep_stringify_keys(EMPTY_OBJECT)))
        tab.each do |k, v|
          res.send("#{k}=", v) if ASSIGNABLE_MEMBERS.include? k
        end
        res
      end
    end

    def initialize(dashboard, json)
      @dashboard = dashboard
      @json = json
    end

    def create_filter_item(item)
      new_item = GutData::FilterItem.create(self, item)
      json['items'] << new_item.json
      new_item
    end

    def create_filter_apply_item(item)
      new_item = GutData::FilterApplyItem.create(self, item)
      json['items'] << new_item.json
      new_item
    end

    def create_geo_chart_item(item)
      new_item = GutData::GeoChartItem.create(self, item)
      json['items'] << new_item.json
      new_item
    end
    alias_method :add_geo_chart_item, :create_geo_chart_item

    def create_headline_item(item)
      new_item = GutData::HeadlineItem.create(self, item)
      json['items'] << new_item.json
      new_item
    end
    alias_method :add_headline_item, :create_headline_item

    def create_iframe_item(item)
      new_item = GutData::IframeItem.create(self, item)
      json['items'] << new_item.json
      new_item
    end
    alias_method :add_iframe_item, :create_iframe_item

    def create_report_item(item)
      new_item = GutData::ReportItem.create(self, item)
      json['items'] << new_item.json
      new_item
    end
    alias_method :add_report_item, :create_report_item

    def create_text_item(item)
      new_item = GutData::TextItem.create(self, item)
      json['items'] << new_item.json
      new_item
    end
    alias_method :add_text_item, :create_text_item

    def identifier
      @json['identifier']
    end

    def identifier=(new_identifier)
      @json['identifier'] = new_identifier
    end

    def items
      @json['items'].map do |item|
        type = item.keys.first
        case type
        when 'filterItem'
          GutData::FilterItem.new(self, item)
        when 'filterApplyItem'
          GutData::FilterApplyItem.new(self, item)
        when 'geoChartItem'
          GutData::GeoChartItem.new(self, item)
        when 'headlineItem'
          GutData::HeadlineItem.new(self, item)
        when 'iframeItem'
          GutData::IframeItem.new(self, item)
        when 'reportItem'
          GutData::ReportItem.new(self, item)
        when 'textItem'
          GutData::TextItem.new(self, item)
        else
          GutData::DashboardItem.new(self, item)
        end
      end
    end

    def title
      @json['title']
    end

    def title=(new_title)
      @json['title'] = new_title
    end
  end
end
