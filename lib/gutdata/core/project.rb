# encoding: UTF-8
#
# Copyright (c) 2010-2015 GutData Corporation. All rights reserved.
# This source code is licensed under the BSD-style license found in the
# LICENSE file in the root directory of this source tree.

module GutData
  @project = nil

  class << self
    # Sets the active project
    #
    # @param project A project identifier
    #
    # ### Examples
    #
    # The following calls are equivalent
    #
    #     # Assign project ID
    #     GutData.project = 'afawtv356b6usdfsdf34vt'
    #
    #     # Use project ID
    #     GutData.use 'afawtv356b6usdfsdf34vt'
    #
    #     # Use project URL
    #     GutData.use '/gdc/projects/afawtv356b6usdfsdf34vt'
    #
    #     # Select project using indexer on GutData::Project class
    #     GutData.project = Project['afawtv356b6usdfsdf34vt']
    # Assigns global/default GutData project
    def project=(project, opts = { :client => GutData.connection })
      if project.is_a? Project
        @project = project
      elsif project.nil?
        @project = nil
      else
        @project = Project[project, opts]
      end
      @project
    end

    alias_method :use, :project=

    attr_reader :project

    # Returns the active project
    #
    # def project
    #   threaded[:project]
    # end

    # Perform block in context of another project than currently set
    #
    # @param project Project to use
    # @param bl Block to be performed
    def with_project(project, opts = { :client => GutData.connection }, &bl)
      fail 'You have to specify a project when using with_project' if project.nil? || (project.is_a?(String) && project.empty?)
      fail 'You have to specify block' unless bl
      old_project = GutData.project

      begin
        GutData.use(project, opts)
        res = bl.call(GutData.project)
      rescue RestClient::ResourceNotFound
        GutData.project = old_project
        raise(GutData::ProjectNotFound, 'Project was not found')
      end

      GutData.project = old_project

      res
    end
  end
end
