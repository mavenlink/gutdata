# encoding: UTF-8
#
# Copyright (c) 2010-2015 GoodData Corporation. All rights reserved.
# This source code is licensed under the BSD-style license found in the
# LICENSE file in the root directory of this source tree.

require 'gutdata/bricks/brick'
require 'gutdata/bricks/bricks'
require 'gutdata/bricks/middleware/bench_middleware'

describe GutData::Bricks::BenchMiddleware do
  it "Has GutData::Bricks::BenchMiddleware class" do
    GutData::Bricks::BenchMiddleware.should_not == nil
  end
end
