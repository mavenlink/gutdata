# encoding: UTF-8
#
# Copyright (c) 2010-2015 GoodData Corporation. All rights reserved.
# This source code is licensed under the BSD-style license found in the
# LICENSE file in the root directory of this source tree.

require 'gutdata/helpers/csv_helper'

describe GutData::Helpers::Csv do
  describe '#read' do
    it 'Reads data from CSV file' do
      data = GutData::Helpers::Csv.read(:path => CsvHelper::CSV_PATH_IMPORT)
    end
  end

  describe '#write' do
    it 'Writes data to CSV' do
      data = []
      GutData::Helpers::Csv.write(:path => CsvHelper::CSV_PATH_EXPORT, :data => data)
    end
  end
end