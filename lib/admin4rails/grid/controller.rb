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
            res_id = resource.belongs_to_id
            if res_id.nil?
              scope.page(params[:page])
            else
              scope.where(res_id => params[res_id]).page(params[:page])
            end
          end
        end

        def grid_params(resource, params)
          params["admin4rails_#{resource.model_name.underscore.pluralize}_grid".to_sym]
        end

        def grid_controller(resource)
          Admin4rails.const_get(grid_controller_name(resource))
        end

        def grid_controller_name(resource)
          "#{resource.model_name.pluralize}Grid"
        end

        private

        def setup_controller_ancestor(resource)
          grid_ancestor = "Admin4rails::#{grid_controller_name(resource)}Ancestor"
          eval "class #{grid_ancestor} < GridParent; end"
          Admin4rails.const_get(grid_ancestor).resource = resource
          grid_ancestor
        end

        def setup_controller(resource, grid_ancestor)
          if Utility.module_exists?("::#{grid_controller_name(resource)}Controller")
            included_module = "extend ::#{grid_controller_name(resource)}Controller"
          end

          grid_controller = "Admin4rails::#{grid_controller_name(resource)}"
          eval "
            class #{grid_controller} < #{grid_ancestor}
              #{included_module}
              include Datagrid
              include Admin4rails::Grid::Base
            end
          "
        end
      end
    end
  end
end
