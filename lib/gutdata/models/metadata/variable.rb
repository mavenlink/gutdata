# encoding: UTF-8
#
# Copyright (c) 2010-2015 GutData Corporation. All rights reserved.
# This source code is licensed under the BSD-style license found in the
# LICENSE file in the root directory of this source tree.

require_relative '../metadata'

require_relative 'metadata'

module GutData
  class Variable < MdObject
    class << self
      # Method intended to get all objects of that type in a specified project
      #
      # @param options [Hash] the options hash
      # @option options [Boolean] :full if passed true the subclass can decide to pull in full objects. This is desirable from the usability POV but unfortunately has negative impact on performance so it is not the default
      # @return [Array<GutData::MdObject> | Array<Hash>] Return the appropriate metadata objects or their representation
      def all(options = { :client => GutData.connection, :project => GutData.project })
        query('prompt', Variable, options)
      end

      def create(data, options = { :client => GutData.connection, :project => GutData.project })
        title = data[:title]
        project = options[:project]
        c = client(options)
        attribute = project.attributes(data[:attribute])

        payload = {
          'prompt' => {
            'content' => {
              'attribute' => attribute.uri,
              'type' => 'filter'
            },
            'meta' => {
              'tags' => '',
              'deprecated' => '0',
              'summary' => '',
              'title' => title,
              'category' => 'prompt'
            }
          }
        }
        c.create(self, payload, project: project)
      end
    end

    # Retrieves variable values
    #
    # @return [Array<GutData::VariableUserFilter>] Values of variable
    def values
      payload = {
        variablesSearch: {
          variables: [
            uri
          ],
          context: []
        }
      }
      client.post("/gdc/md/#{project.pid}/variables/search", payload)['variables'].map { |f| client.create(GutData::VariableUserFilter, f, project: project) }
    end

    # Retrieves variable values and returns only those related to user
    #
    # @return [Array<GutData::VariableUserFilter>] Values of variable related to user
    def user_values
      values.select { |x| x.level == :user }
    end

    # Method used for replacing values in their state according to mapping. Can be used to replace any values but it is typically used to replace the URIs. Returns a new object of the same type.
    #
    # @param [Array<Array>]Mapping specifying what should be exchanged for what. As mapping should be used output of GutData::Helpers.prepare_mapping.
    # @return [GutData::Variable]
    def replace(mapping)
      GutData::MdObject.replace_quoted(self, mapping)
    end

    # Retrieves variable values and returns only those related to project
    #
    # @return [Array<GutData::VariableUserFilter>] Values of variable related to project
    def project_values
      values.select { |x| x.level == :project }
    end

    # Deletes all the values and eventually the variable itself
    def delete
      values.pmap(&:delete)
      super
    end
  end
end
