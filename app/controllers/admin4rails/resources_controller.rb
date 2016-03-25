require_dependency "admin4rails/application_controller"

require 'admin4rails/plugins/datagrid/grid'

module Admin4rails
  class ResourcesController < ApplicationController
    before_filter :set_resource

    def index
      @records = resource.all

      eval %{
        class Admin4rails::PostsGrid
          include Datagrid
          include Admin4rails::Plugins::DataGrid::Grid
          def self.resource=(res); @@resource = res end
          def resource; @@resource end
        end
      }
      Admin4rails::PostsGrid.resource = resource

      @grid = Admin4rails::PostsGrid.new(params[:grid])

      respond_to do |format|
        format.html
        format.json { render json: @records }
      end
    end

    def show
    end

    def edit
    end

    def new
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
