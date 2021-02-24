# encoding: UTF-8
#
# Copyright (c) 2010-2015 GutData Corporation. All rights reserved.
# This source code is licensed under the BSD-style license found in the
# LICENSE file in the root directory of this source tree.

module GutData
  module Mixin
    module MdIdToUri
      IDENTIFIERS_CFG = 'instance-identifiers'

      # TODO: Add test
      def identifier_to_uri(opts = { :client => GutData.connection, :project => GutData.project }, *ids)
        client, project = GutData.get_client_and_project(opts)

        uri = project.md[IDENTIFIERS_CFG]
        response = client.post uri, 'identifierToUri' => ids
        if response['identifiers'].empty?
          nil
        else
          identifiers = response['identifiers']
          ids_lookup = identifiers.reduce({}) do |a, e|
            a[e['identifier']] = e['uri']
            a
          end
          uris = ids.map { |x| ids_lookup[x] }
          uris.count == 1 ? uris.first : uris
        end
      end

      alias_method :id_to_uri, :identifier_to_uri
    end
  end
end
