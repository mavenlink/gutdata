# encoding: UTF-8
#
# Copyright (c) 2010-2015 GoodData Corporation. All rights reserved.
# This source code is licensed under the BSD-style license found in the
# LICENSE file in the root directory of this source tree.

# Global requires
require 'multi_json'
require 'pmap'

# Local requires
require 'gutdata/models/models'

require_relative '../environment/environment'

GutData::Environment.load

module GutData::Helpers
  module ProcessHelper
    include GutData::Environment::ProcessHelper

    class << self
      def remove_old_processes(project)
        processes = project.processes
        processes.pmap do |process|
          next if process.obj_id == GutData::Environment::ProcessHelper::PROCESS_ID
          puts "Deleting #{process.inspect}"
          process.delete
        end
      end
    end
  end
end
