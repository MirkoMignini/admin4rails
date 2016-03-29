require_dependency 'admin4rails/application_controller'

require 'admin4rails/plugins/datagrid/grid'

module Admin4rails
  class ResourcesController < ApplicationController
    before_action :set_resource

    def index
      # @records = resource.all

      grid_base = "Admin4rails::#{resource.model_name.pluralize}GridBase"
      eval "
        class #{grid_base}
          def self.resource=(res); @@resource = res end
          def self.resource; @@resource end
          def resource; @@resource end
        end
      "
      Admin4rails.const_get(grid_base).resource = resource

      grid_controller = "Admin4rails::#{resource.model_name.pluralize}Grid"
      eval "
        class #{grid_controller} < #{grid_base}
          include Datagrid
          include Admin4rails::Plugins::DataGrid::Grid
        end
      "

      @grid = Admin4rails.const_get(grid_controller).new(params[:grid]) do |scope|
        scope.page(params[:page])
      end

      respond_to do |format|
        format.html
        format.json { render json: resource.all }
      end
    end

    def show
    end

    def edit
    end

    def new
      @record = resource.klass.new
    end

    def create
    end

    def update
    end

    def delete
    end

    private

    def set_resource
      @resource = resource
    end
  end
end
