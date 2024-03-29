# encoding: UTF-8
#
# Copyright (c) 2010-2015 GoodData Corporation. All rights reserved.
# This source code is licensed under the BSD-style license found in the
# LICENSE file in the root directory of this source tree.

module GutData
  module Command
    # Also known as ADS and DSS
    class DataWarehouse
      class << self
        # Create new project based on options supplied
        def create(options = { client: GutData.connection })
          description = options[:summary] || options[:description]
          GutData::DataWarehouse.create(options.merge(:description => description))
        end
      end
    end
  end
end
