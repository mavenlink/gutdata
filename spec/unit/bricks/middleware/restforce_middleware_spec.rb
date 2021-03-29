# encoding: UTF-8
#
# Copyright (c) 2010-2015 GoodData Corporation. All rights reserved.
# This source code is licensed under the BSD-style license found in the
# LICENSE file in the root directory of this source tree.

require 'gutdata/bricks/brick'
require 'gutdata/bricks/bricks'
require 'gutdata/bricks/middleware/restforce_middleware'

  describe GutData::Bricks::RestForceMiddleware do
  it "Has GutData::Bricks::RestForceMiddleware class" do
    GutData::Bricks::RestForceMiddleware.should_not == nil
  end
end
