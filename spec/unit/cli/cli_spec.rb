# encoding: UTF-8
#
# Copyright (c) 2010-2015 GoodData Corporation. All rights reserved.
# This source code is licensed under the BSD-style license found in the
# LICENSE file in the root directory of this source tree.

require 'gutdata/cli/cli'

describe GutData::CLI do
  it 'Has GutData::CLI class' do
    GutData::CLI.should_not == nil
  end

  it 'Has GutData::CLI::main() working' do
    run_cli
  end
end