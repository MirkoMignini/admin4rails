require 'admin4rails/grid/controller'
require 'admin4rails/grid/controller'

module Admin4rails
  module GridUtils
    extend ActiveSupport::Concern

    def setup_grid(res)
      unless Utility.module_exists?(Admin4rails::Grid::Controller.grid_controller_name(res))
        Admin4rails::Grid::Controller.create_controller(res)
      end
      Admin4rails.const_get(Admin4rails::Grid::Controller.grid_controller_name(res)).resource = res
    end

    def prepare_grid(res, params)
      Admin4rails::Grid::Controller.grid(res, params)
    end
  end
end
