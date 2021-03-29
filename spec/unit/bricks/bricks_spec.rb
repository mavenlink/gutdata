# encoding: UTF-8
#
# Copyright (c) 2010-2015 GoodData Corporation. All rights reserved.
# This source code is licensed under the BSD-style license found in the
# LICENSE file in the root directory of this source tree.

require 'gutdata/bricks/bricks'

describe GutData::Bricks::Brick do
  it "Has GutData::Bricks::Brick class" do
    GutData::Bricks::Brick.should_not == nil
  end

  describe '#version' do
    it 'Throws NotImplemented on base class' do
      brick = GutData::Bricks::Brick.new
      expect do
        brick.version
      end.to raise_error(NotImplementedError)
    end
  end

  it "should be possible to execute custom brick" do
    class CustomBrick < GutData::Bricks::Brick

      def call(params)
        puts 'hello'
      end
    end

    p = GutData::Bricks::Pipeline.prepare([CustomBrick])

    p.call({})
  end
end
