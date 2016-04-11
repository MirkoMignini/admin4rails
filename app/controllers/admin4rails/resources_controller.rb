require_dependency 'admin4rails/application_controller'
require 'admin4rails/grid/controller'

module Admin4rails
  class ResourcesController < ApplicationController
    before_action :set_resource

    def index
      setup_grid

      respond_to do |format|
        format.html { @grid = Admin4rails::Grid::Controller.grid(resource, params) }
        format.json { render(json: resource.all) }
      end
    end

    def show
      @attributes = resource.filter_attributes(show_fields)
      set_record
    end

    def edit
      @form_type = :edit
      @attributes = resource.filter_attributes(edit_fields)
      set_record
    end

    def new
      @form_type = :new
      @attributes = resource.filter_attributes(new_fields)
      @record = resource.klass.new
    end

    def create
      @attributes = resource.filter_attributes(new_fields)
      @record = resource.klass.create(create_params)
      respond_to do |format|
        if @record.save
          format.html { redirect_to(@record, saved: 'Record was successfully created.') }
          format.json { render(:show, status: :created, location: @record) }
        else
          format.html { render(:new) }
          format.json { render(json: @record.errors, status: :unprocessable_entity) }
        end
      end
    end

    def update
      set_record
      @attributes = resource.filter_attributes(edit_fields)
      @record.update(update_params)
      respond_to do |format|
        if @record.save
          format.html { redirect_to(@record, notice: 'Record was successfully updated.') }
          format.json { render(:show, status: :ok, location: @record) }
        else
          format.html { render(:edit) }
          format.json { render(json: @record.errors, status: :unprocessable_entity) }
        end
      end
    end

    def destroy
      set_record
      @record.destroy
      respond_to do |format|
        format.html { redirect_to(resource.index_path, notice: 'Record was successfully destroyed.') }
        format.json { head(:no_content) }
      end
    end

    private

    def new_fields
      resource.edit_attributes.map(&:name)
    end

    def edit_fields
      resource.edit_attributes.map(&:name)
    end

    def show_fields
      resource.attributes.map(&:name)
    end

    def setup_grid
      unless Utility.module_exists?(Admin4rails::Grid::Controller.grid_controller_name(resource))
        Admin4rails::Grid::Controller.create_controller(resource)
      end
    end

    %w(create_params update_params).each do |method_name|
      define_method(method_name) do |*args|
        permitted_params = resource.permitted_params(@attributes)
        params.require(resource.klass.name.underscore.to_sym).permit(permitted_params)
      end
    end

    def set_record
      @record = resource.klass.find(params[:id])
    end

    def set_resource
      @resource = resource
    end
  end
end
