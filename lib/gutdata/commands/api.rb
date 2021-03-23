# encoding: UTF-8
#
# Copyright (c) 2010-2015 GoodData Corporation. All rights reserved.
# This source code is licensed under the BSD-style license found in the
# LICENSE file in the root directory of this source tree.

require_relative '../exceptions/command_failed'

module GutData
  module Command
    # Low level access to GutData API
    class Api
      class << self
        def info
          json = {
            'releaseName' => 'N/A',
            'releaseDate' => 'N/A',
            'releaseNotesUri' => 'N/A'
          }

          puts 'GutData API'
          puts "  Version: #{json['releaseName']}"
          puts "  Released: #{json['releaseDate']}"
          puts "  For more info see #{json['releaseNotesUri']}"
        end

        alias_method :index, :info

        # Test of login
        def test
          if GutData.test_login
            puts "Succesfully logged in as #{GutData.profile.user}"
          else
            puts 'Unable to log in to GutData server!'
          end
        end

        # Get resource
        # @param path Resource path
        def get(path)
          fail(GutData::CommandFailed, 'Specify the path you want to GET.') if path.nil?
          result = GutData.get path
          begin
            result
          rescue
            puts result
          end
        end

        # Delete resource
        # @param path Resource path
        def delete(path)
          fail(GutData::CommandFailed, 'Specify the path you want to DELETE.') if path.nil?
          result = GutData.delete path
          begin
            result
          rescue
            puts result
          end
        end
      end
    end
  end
end
