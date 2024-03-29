# encoding: UTF-8
#
# Copyright (c) 2010-2015 GoodData Corporation. All rights reserved.
# This source code is licensed under the BSD-style license found in the
# LICENSE file in the root directory of this source tree.

require 'erubis'
require 'fileutils'
require 'pathname'

module GutData
  module Command
    class Scaffold
      TEMPLATES_PATH = Pathname(__FILE__) + '../../../templates'

      class << self
        # Scaffolds new project
        # TODO: Add option for custom output dir
        def project(name)
          fail ArgumentError, 'No name specified' if name.nil?

          FileUtils.mkdir(name)
          FileUtils.cd(name) do
            FileUtils.mkdir('model')
            FileUtils.cd('model') do
              input = File.read(TEMPLATES_PATH + 'project/model/model.rb.erb')
              eruby = Erubis::Eruby.new(input)
              File.open('model.rb', 'w') do |f|
                f.write(eruby.result(:name => name))
              end
            end

            FileUtils.mkdir('data')
            FileUtils.cd('data') do
              FileUtils.cp(Dir.glob(TEMPLATES_PATH + 'project/data/*.csv'), '.')
            end

            input = File.read(TEMPLATES_PATH + 'project/Goodfile.erb')
            eruby = Erubis::Eruby.new(input)
            File.open('Goodfile', 'w') do |f|
              f.write(eruby.result)
            end
          end
        end
      end
    end
  end
end
