require 'datagrid'
require 'admin4rails/plugins/datagrid/grid'

module Admin4rails
  module Plugins
    module DataGrid
      class << self
        def setup
          Admin4rails.resources.each do |resource|
            setup_resource(resource)
          end
          Admin4rails.dsl.controller.index_proc = lambda do |controller, resource, params|
            index(controller, resource, params)
          end
          Admin4rails.dsl.controller.index_file =
            File.expand_path('lib/admin4rails/plugins/datagrid/index.html.haml',
                             Admin4rails::Engine.root)
        end

        def grid_controller(resource)
          Admin4rails.const_get("Admin4rails::#{resource.model_name.pluralize}Grid")
        end

        private

        def index(controller, resource, params)
          result = grid_controller(resource).new(params[:grid]) do |scope|
            scope.page(params[:page])
          end
          controller.instance_variable_set('@grid', result)
        end

        def setup_resource(resource)
          base = setup_controller_base(resource)
          setup_controller(resource, base)
        end

        def setup_controller_base(resource)
          grid_base = "Admin4rails::#{resource.model_name.pluralize}GridBase"
          eval "
            class #{grid_base}
              def self.resource=(res); @@resource = res end
              def self.resource; @@resource end
              def resource; @@resource end
            end
          "
          Admin4rails.const_get(grid_base).resource = resource
          grid_base
        end

        def setup_controller(resource, grid_base)
          grid_controller = "Admin4rails::#{resource.model_name.pluralize}Grid"
          eval "
            class #{grid_controller} < #{grid_base}
              include Datagrid
              include Admin4rails::Plugins::DataGrid::Grid
            end
          "
        end
      end
    end
  end
end

Admin4rails::Plugins::DataGrid.setup
