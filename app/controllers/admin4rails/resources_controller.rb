require_dependency 'admin4rails/application_controller'

module Admin4rails
  class ResourcesController < ApplicationController
    before_action :set_resource
    before_action :set_record, only: [:show, :edit, :update, :destroy]

    def index
      if dsl.controller.index? && dsl.controller.index.override?
        return instance_eval(&dsl.controller.index.override)
      end

      respond_to do |format|
        format.html { @grid = Admin4rails::Grid::Controller.grid(resource, params) }
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

    def dsl
      Admin4rails.dsl
    end

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
