# encoding: UTF-8
#
# Copyright (c) 2010-2015 GoodData Corporation. All rights reserved.
# This source code is licensed under the BSD-style license found in the
# LICENSE file in the root directory of this source tree.

require 'gutdata/models/metadata/metric'

describe GutData::Metric do


  RAW_DATA2 = {'metric' =>
                 {'content' =>
                    {'format' => '#,##0',
                     'expression' => 'SELECT SUM([/gdc/md/ksjy0nr3goz6k8yrpklz97l0mych7nez/obj/700])'},
                  'meta' =>
                    {'author' => '/gdc/account/profile/4e1e8cacc4989228e0ae531b30853248',
                     'uri' => '/gdc/md/ksjy0nr3goz6k8yrpklz97l0mych7nez/obj/70',
                     'tags' => 'a b cg r t',
                     'created' => '2014-04-30 22:47:57',
                     'identifier' => 'afo7bx1VakCz',
                     'deprecated' => '0',
                     'summary' => '',
                     'locked' => 0,
                     'title' => 'sum of Lines changed',
                     'category' => 'metric',
                     'updated' => '2014-05-05 20:00:42',
                     'contributor' => '/gdc/account/profile/4e1e8cacc4989228e0ae531b30853248'}}}

  RAW_DATA3 = {'metric' =>
                 {'content' =>
                    {'format' => '#,##0',
                     'expression' => 'SELECT SUM([/gdc/md/ksjy0nr3goz6k8yrpklz97l0mych7nez/obj/710])'},
                  'meta' =>
                    {'author' => '/gdc/account/profile/4e1e8cacc4989228e0ae531b30853248',
                     'uri' => '/gdc/md/ksjy0nr3goz6k8yrpklz97l0mych7nez/obj/71',
                     'tags' => 'a b cg r t',
                     'created' => '2014-04-30 22:47:57',
                     'identifier' => 'afo7bx1VakCz',
                     'deprecated' => '0',
                     'summary' => '',
                     'locked' => 1,
                     'title' => 'sum of Lines changed',
                     'category' => 'metric',
                     'updated' => '2014-05-05 20:00:42',
                     'contributor' => '/gdc/account/profile/4e1e8cacc4989228e0ae531b30853248'}}}

  USED_METRIC = GutData::Metric.new(RAW_DATA2)
  UNUSED_METRIC = GutData::Metric.new(RAW_DATA3)

  RAW_DATA = {'metric' =>
                {'content' =>
                   {'format' => '#,##0',
                    'expression' =>
                      "SELECT SUM([#{USED_METRIC.uri}])"},
                 'meta' =>
                   {'author' => '/gdc/account/profile/4e1e8cacc4989228e0ae531b30853248',
                    'uri' => '/gdc/md/ksjy0nr3goz6k8yrpklz97l0mych7nez/obj/252',
                    'tags' => 'a b cg r t',
                    'created' => '2014-04-30 22:47:57',
                    'identifier' => 'afo7bx1VakCz',
                    'deprecated' => '0',
                    'summary' => '',
                    'locked' => 0,
                    'title' => 'sum of Lines changed',
                    'category' => 'metric',
                    'updated' => '2014-05-05 20:00:42',
                    'contributor' => '/gdc/account/profile/4e1e8cacc4989228e0ae531b30853248'}}}

  before(:each) do
    @instance = GutData::Metric.new(RAW_DATA)
  end

  describe '#contain?' do
    it 'should say it contains a depending metric if it does' do
      expect(@instance.contain?(USED_METRIC)).to eq true
    end

    it 'should say it contains a depending object which is given as a string if it does' do
      expect(@instance.contain?(USED_METRIC)).to eq true
    end

    it 'should be able to replace an object if the object is used in the expression' do
      skip('resolve mutating constant if I init from it')
    end

    it 'should be able to return an expression of the metric' do
      expect(@instance.expression).to eq "SELECT SUM([#{USED_METRIC.uri}])"
    end
  end

  describe "#locked?" do
    it "should be able to say if an object is locked" do
      expect(@instance.locked?).to eq false
    end
  end

  describe "#unlocked?" do
    it "should be able to say if an object is unlocked" do
      expect(@instance.unlocked?).to eq true
    end
  end

  describe "#lock" do
    it "should be able to lock an object" do
      expect(@instance.locked?).to eq false
      @instance.lock
      expect(@instance.locked?).to eq true
    end
  end

  describe "#lock" do
    it "should be able to unlock an object" do
      @instance.lock
      expect(@instance.locked?).to eq true
      @instance.unlock
      expect(@instance.locked?).to eq false
      expect(@instance.unlocked?).to eq true
    end
  end
end
