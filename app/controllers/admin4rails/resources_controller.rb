require_dependency "admin4rails/application_controller"
require 'pp'

module Admin4rails
  class ResourcesController < ApplicationController
    def index
      @records = resource.all
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

    def resource
      @@resource
    end

    def self.resource=(resource)
      @@resource = resource
    end

    def self.resource
      @@resource
    end
  end
end
