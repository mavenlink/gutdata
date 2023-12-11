# encoding: UTF-8
#
# Copyright (c) 2010-2015 GoodData Corporation. All rights reserved.
# This source code is licensed under the BSD-style license found in the
# LICENSE file in the root directory of this source tree.

require 'date'

require_relative '../data/guesser'
require_relative '../extract'
require_relative '../exceptions/command_failed'

module GutData
  module Command
    class Datasets
      # List all data sets present in the project specified by the --project option
      #
      # ## Usage
      #
      #     gutdata datasets --project <projectid>
      #     gutdata datasets:list --project <projectid>
      #
      # * `--project` - GutData project identifier
      #
      def index
        # TODO: Review following connect replacement/reimplementation
        # connect
        with_project do |project_id|
          Project[project_id].datasets.each do |ds|
            puts "#{ds.uri}\t#{ds.identifier}\t#{ds.title}"
          end
        end
      end

      # Describe a data set. Currently, only a CSV data set is supported.
      #
      # The command prescans the data set, picks possible LDM types for it's
      # fields and asks user for confirmation.
      #
      # ## Usage
      #
      #     gutdata datasets:describe --file-csv <path> --name <name> --output <output path>
      #
      # * `--file-csv` - path to the CSV file (required)
      # * `--name` - name of the data set (user will be prompted unless provided)
      # * `--output` - name of the output JSON file with the model description (user will be prompted unless provided)
      #
      def describe
        columns = ask_for_fields
        name = extract_option('--name') || ask('Enter the dataset name')
        output = extract_option('--output') || ask('Enter path to the file where to save the model description', :default => "#{name}.json")
        open output, 'w' do |f|
          f << JSON.pretty_generate(:title => name, :columns => columns) + "\n"
          f.flush
        end
      end

      # Creates a server-side model based on local model description. The model description
      # is read from a JSON file that can be generated using the +datasets:describe+ command
      #
      # ## Usage
      #
      #     gutdata datasets:apply --project <projectid> <data set config>
      #
      # * `--project`- GutData project identifier
      # * `data set config` - JSON file with the model description (possibly generated by the <tt>datasets:describe</tt> command)
      #
      def apply
        # TODO: Review following connect replacement/reimplementation
        # connect
        with_project do |project_id|
          begin
            cfg_file = args.shift
          rescue
            raise(CommandFailed, 'Invalid arguments')
          end

          fail(CommandFailed, "Usage: #{$PROGRAM_NAME} <dataset config>") unless cfg_file
          config = begin
            JSON.load open(cfg_file)
          rescue
            raise(CommandFailed, "Error reading dataset config file '#{cfg_file}'")
          end
          objects = Project[project_id].add_dataset config['title'], config['columns']
          puts "Dataset #{config['title']} added to the project, #{objects['uris'].length} metadata objects affected"
        end
      end

      # Loads a CSV file into an existing server-side data set
      #
      # ## Usage
      #
      #     gutdata datasets:load --project <projectid> <file> <dataset config><
      #
      # * `--project` - GutData project identifier
      # * `file` - CSV file to load
      # * `data set config` - JSON file with the model description (possibly generated by the <tt>datasets:describe</tt> command)
      #
      def load
        # TODO: Review following connect replacement/reimplementation
        # connect
        with_project do |project_id|
          file, cfg_file = args
          fail(CommandFailed, "Usage: #{$PROGRAM_NAME} datasets:load <file> <dataset config>") unless cfg_file
          begin
            config = JSON.load open(cfg_file)
          rescue
            raise(CommandFailed, "Error reading dataset config file '#{cfg_file}'")
          end
          schema = Model::Schema.new config
          Project[project_id].upload file, schema
        end
      end

      private

      def with_project
        unless @project_id
          @project_id = extract_option('--project')
          fail(CommandFailed, 'Project not specified, use the --project switch') unless @project_id
        end
        yield @project_id
      end

      def ask_for_fields
        guesser = GutData::Data::Guesser.new create_dataset.read
        guess = guesser.guess(1000)
        model = []
        connection_point_set = false
        question_fmt = 'Select data type of column #%i (%s)'
        guesser.headers.each_with_index do |header, i|
          options = guess[header].map(&:to_s)
          options = options.select { |t| t != :connection_point.to_s } if connection_point_set
          type = ask((question_fmt % [i + 1, header]), :answers => options)
          model.push :title => header, :name => header, :type => type.upcase
          connection_point_set = true if type == :connection_point.to_s
        end
        model
      end

      def create_dataset
        file = extract_option('--file-csv')
        return Extract::CsvFile.new(file) if file
        fail(CommandFailed, 'Unknown data set. Please specify a data set using --file-csv option (more supported data sources to come!)')
      end
    end
  end
end