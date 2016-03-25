require_dependency "admin4rails/application_controller"

module Admin4rails
  class ResourcesController < ApplicationController
    def index
      @resource = resource
      @records = resource.all
      respond_to do |format|
        format.html
        format.json { render json: index_json }
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

    private

    def index_json
      {
        data: @records
      }
    end
  end
end
