# encoding: UTF-8
#
# Copyright (c) 2010-2015 GoodData Corporation. All rights reserved.
# This source code is licensed under the BSD-style license found in the
# LICENSE file in the root directory of this source tree.

require 'gutdata/core/core'

describe GutData::NilLogger do
  it "Has GutData::NilLogger class" do
    GutData::NilLogger.should_not be(nil)
  end
end