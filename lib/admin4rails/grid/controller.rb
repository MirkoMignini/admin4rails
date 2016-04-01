require 'admin4rails/grid/base'

module Admin4rails
  module Grid
    module Controller
      class << self
        def create_controller(resource)
          ancestor = setup_controller_ancestor(resource)
          setup_controller(resource, ancestor)
        end

        def grid(resource, params)
          grid_controller(resource).new(params[:grid]) do |scope|
            scope.page(params[:page])
          end
        end

        def grid_controller(resource)
          Admin4rails.const_get("Admin4rails::#{resource.model_name.pluralize}Grid")
        end

        private

        def setup_controller_ancestor(resource)
          grid_ancestor = "Admin4rails::#{resource.model_name.pluralize}GridAncestor"
          eval "
            class #{grid_ancestor}
              def self.resource=(res); @@resource = res end
              def self.resource; @@resource end
              def resource; @@resource end
            end
          "
          Admin4rails.const_get(grid_ancestor).resource = resource
          grid_ancestor
        end

        def setup_controller(resource, grid_ancestor)
          grid_controller = "Admin4rails::#{resource.model_name.pluralize}Grid"
          eval "
            class #{grid_controller} < #{grid_ancestor}
              include Datagrid
              include Admin4rails::Grid::Base
            end
          "
        end
      end
    end
  end
end
