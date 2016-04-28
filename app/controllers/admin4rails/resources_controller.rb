require_dependency 'admin4rails/application_controller'

module Admin4rails
  class ResourcesController < ApplicationController
    include Admin4rails::GridUtils

    before_action :set_resource

    def index
      setup_grid(resource)

      respond_to do |format|
        format.html { @grid = prepare_grid(resource, params) }
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
      @record = new_record
    end

    def new_record
      if resource.belongs_to.nil?
        resource.klass.new
      else
        resource.klass.where(resource.belongs_to_id => params[resource.belongs_to_id]).build
      end
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

    %w(create_params update_params).each do |method_name|
      define_method(method_name) do |*_args|
        permitted_params = resource.permitted_params(@attributes)
        params.require(resource.klass.name.underscore.to_sym).permit(permitted_params)
      end
    end

    def set_record
      @record = resource.klass.find(params[:id])
    end

    def set_resource
      @resource = resource
      set_nested_resources
    end

    def set_nested_resources
      @parent_resources = []
      previous = resource
      resource.parents.each do |parent|
        @parent_resources << parent.klass.find(params[previous.belongs_to_id])
        previous = parent
      end
    end
  end
end
