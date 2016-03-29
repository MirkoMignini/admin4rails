require_dependency 'admin4rails/application_controller'

require 'admin4rails/plugins/datagrid/grid'

module Admin4rails
  class ResourcesController < ApplicationController
    before_action :set_resource
    before_action :set_record, only: [:show, :edit, :update, :destroy]

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
      @record = resource.klass.create(record_params)
      respond_to do |format|
        if @record.save
          format.html { redirect_to @record, notice: 'Record was successfully created.' }
          format.json { render :show, status: :created, location: @record }
        else
          format.html { render :new }
          format.json { render json: @record.errors, status: :unprocessable_entity }
        end
      end
    end

    def update
      @record.update(record_params)
      respond_to do |format|
        if @record.save
          format.html { redirect_to @record, notice: 'Record was successfully updated.' }
          format.json { render :show, status: :ok, location: @record }
        else
          format.html { render :edit }
          format.json { render json: @record.errors, status: :unprocessable_entity }
        end
      end
    end

    def destroy
      @record.destroy
      respond_to do |format|
        format.html { redirect_to resource.index_path, notice: 'Record was successfully destroyed.' }
        format.json { head :no_content }
      end
    end

    private

    def record_params
      params.require(resource.klass.name.underscore.to_sym).permit(resource.permitted_params)
    end

    def set_record
      @record = resource.klass.find(params[:id])
    end

    def set_resource
      @resource = resource
    end
  end
end
