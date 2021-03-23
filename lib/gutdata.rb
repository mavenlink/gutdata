# encoding: UTF-8
#
# Copyright (c) 2010-2015 GoodData Corporation. All rights reserved.
# This source code is licensed under the BSD-style license found in the
# LICENSE file in the root directory of this source tree.

require 'pmap'
$pmap_default_thread_count = 20 # rubocop:disable GlobalVars

# GutData Module
module GutData
end

# Modules
require_relative 'gutdata/bricks/bricks'
require_relative 'gutdata/commands/commands'
require_relative 'gutdata/core/core'
require_relative 'gutdata/data/data'
require_relative 'gutdata/exceptions/exceptions'
require_relative 'gutdata/helpers/helpers'
require_relative 'gutdata/models/models'

# Files
require_relative 'gutdata/app/app'
require_relative 'gutdata/client'
require_relative 'gutdata/connection'
require_relative 'gutdata/extract'
require_relative 'gutdata/version'

# Extensions
require_relative 'gutdata/extensions/extensions'
