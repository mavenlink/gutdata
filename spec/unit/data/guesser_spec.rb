# encoding: UTF-8
#
# Copyright (c) 2010-2015 GoodData Corporation. All rights reserved.
# This source code is licensed under the BSD-style license found in the
# LICENSE file in the root directory of this source tree.

require 'gutdata'

describe GutData::Data::Guesser do
  skip('Guesser needs to be redone. Failing due to rubocop fixes.')
  it "order LDM types as follows: cp, fact, date, attribute" do
    expect = [:connection_point, :fact, :date, :attribute]
    result = GutData::Data::Guesser::sort_types([:fact, :attribute, :connection_point, :date])
    result.should == expect

    expect = [:fact]
    result = GutData::Data::Guesser::sort_types([:fact])
    result.should == expect

    expect = []
    result = GutData::Data::Guesser::sort_types([])
    result.should == expect
  end

  it "guess facts, dates and connection points from a simple CSV" do
    skip('Guesser is disabled for now')

    csv = [
      ['cp', 'a1', 'a2', 'd1', 'd2', 'f'],
      ['1', 'one', 'huh', '2001-01-02', nil, '-1'],
      ['2', 'two', 'blah', nil, '1970-10-23', '2.3'],
      ['3', 'three', 'bleh', '0000-00-00', nil, '-3.14159'],
      ['4', 'one', 'huh', '2010-02-28 08:12:34', '1970-10-23', nil]
    ]

    fields = GutData::Data::Guesser.new(csv).guess(csv.size + 10)

    expect = GutData::Data::Guesser::sort_types([:connection_point, :fact, :attribute])
    result = fields['cp']
    result.should == expect

    expect = [:attribute]
    result = fields['a1']
    expect.should == result

    expect = [:attribute]
    result = fields['a2']
    result.should == expect

    expect = GutData::Data::Guesser::sort_types([:attribute, :connection_point, :date])
    result = fields['d1']
    result.should == expect

    expect = GutData::Data::Guesser::sort_types([:attribute, :date])
    result = fields['d2']
    result.should == expect

    expect = GutData::Data::Guesser::sort_types([:attribute, :connection_point, :fact])
    result = fields['f']
    result.should == expect

  end
end