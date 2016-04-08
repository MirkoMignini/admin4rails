require_dependency 'admin4rails/application_controller'

module Admin4rails
  class ResourcesController < ApplicationController
    before_action :set_resource

    def index
      return if handle_event('index_override')

      handle_event('index_before')
      unless handle_event('index_render')
        respond_to do |format|
          format.html { @grid = Admin4rails::Grid::Controller.grid(resource, params) }
          format.json { render(json: resource.all) }
        end
      end
      handle_event('index_after')
    end

    def show
      return if handle_event('show_override')

      handle_event(:show, :before)
      set_attributes(:show, resource.attributes)
      set_record
      handle_event(:show, :after)
    end

    def edit
      return if handle_event('edit_override')

      handle_event('edit_before')
      @form_type = :edit_form
      set_attributes(:edit_form, resource.edit_attributes)
      set_record
      handle_event('edit_after')
    end

    def new
      return if handle_event('new_override')

      handle_event('new_before')
      @form_type = :new_form
      set_attributes(:new_form, resource.edit_attributes)
      @record = resource.klass.new
      handle_event('new_after')
    end

    def create
      return if handle_event('create_override')

      handle_event('create_before')
      set_attributes(:new_form, resource.edit_attributes)
      @record = resource.klass.create(record_params(:new_form))
      saved = @record.save
      unless handle_event('create_render', saved: saved)
        respond_to do |format|
          if saved
            format.html { redirect_to(@record, saved: 'Record was successfully created.') }
            format.json { render(:show, status: :created, location: @record) }
          else
            format.html { render(:new) }
            format.json { render(json: @record.errors, status: :unprocessable_entity) }
          end
        end
      end
      handle_event('create_after')
    end

    def update
      return if handle_event('update_override')

      handle_event('update_before')
      set_record
      set_attributes(:edit_form, resource.edit_attributes)
      @record.update(record_params(:edit_form))
      saved = @record.save
      unless handle_event('update_render', saved: saved)
        respond_to do |format|
          if saved
            format.html { redirect_to(@record, notice: 'Record was successfully updated.') }
            format.json { render(:show, status: :ok, location: @record) }
          else
            format.html { render(:edit) }
            format.json { render(json: @record.errors, status: :unprocessable_entity) }
          end
        end
      end
      handle_event('update_after')
    end

    def destroy
      return if handle_event('destroy_override')

      handle_event('destroy_before')
      set_record
      @record.destroy
      unless handle_event('destroy_render')
        respond_to do |format|
          format.html { redirect_to(resource.index_path, notice: 'Record was successfully destroyed.') }
          format.json { head(:no_content) }
        end
      end
      handle_event('destroy_after')
    end

    private

    def record_params(method_symbol)
      permitted_params = if resource.dsl.send("#{method_symbol}?".to_sym) &&
          resource.dsl.send(method_symbol).permitted_params?
        resource.dsl.send(method_symbol).permitted_params
      else
        resource.permitted_params(@attributes)
      end
      params.require(resource.klass.name.underscore.to_sym).permit(permitted_params)
    end

    def set_attributes(method, default)
      @attributes = resource.attributes_or_default(resource.dsl.send(method), default)
    end

    def set_record
      return if handle_event('set_record_override')
      @record = resource.klass.find(params[:id])
    end

    def set_resource
      @resource = resource
    end

    def handle_event(event, *args)
      resource.handle_event(self, event, args)
    end
  end
end
