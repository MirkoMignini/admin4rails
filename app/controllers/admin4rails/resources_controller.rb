require_dependency 'admin4rails/application_controller'

module Admin4rails
  class ResourcesController < ApplicationController
    before_action :set_resource
    before_action :set_record, only: [:show, :edit, :update, :destroy]

    def index
      # if Admin4rails.dsl.controller.index?
      #  Admin4rails.dsl.controller.index.call(self, resource, params)
      # else
      # @records = resource.all

      # unless Admin4rails.dsl.controller.index_file?
      @grid = Admin4rails::Grid::Controller.grid(resource, params)
      respond_to do |format|
        format.html
        format.json { render json: resource.all }
      end
      # end
      # end

      # if Admin4rails.dsl.controller.index_file?
      #  render(file: Admin4rails.dsl.controller.index_file)
      # end
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
