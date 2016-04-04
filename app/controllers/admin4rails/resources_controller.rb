require_dependency 'admin4rails/application_controller'

module Admin4rails
  class ResourcesController < ApplicationController
    before_action :set_resource

    def index
      return if handle_event(:index, :override)

      handle_event(:index, :before)
      unless handle_event(:index, :render)
        respond_to do |format|
          format.html { @grid = Admin4rails::Grid::Controller.grid(resource, params) }
          format.json { render(json: resource.all) }
        end
      end
      handle_event(:index, :after)
    end

    def show
      return if handle_event(:show, :override)

      handle_event(:show, :before)
      set_record
      handle_event(:show, :after)
    end

    def edit
      return if handle_event(:edit, :override)

      handle_event(:edit, :before)
      set_record
      handle_event(:edit, :after)
    end

    def new
      return if handle_event(:new, :override)

      handle_event(:new, :before)
      @record = resource.klass.new
      handle_event(:new, :after)
    end

    def create
      return if handle_event(:create, :override)

      handle_event(:create, :before)
      @record = resource.klass.create(record_params)
      saved = @record.save
      unless handle_event(:create, :render, saved: saved)
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
      handle_event(:create, :after)
    end

    def update
      return if handle_event(:update, :override)

      handle_event(:update, :before)
      set_record
      @record.update(record_params)
      saved = @record.save
      unless handle_event(:update, :render, saved: saved)
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
      handle_event(:update, :after)
    end

    def destroy
      return if handle_event(:destroy, :override)

      handle_event(:destroy, :before)
      set_record
      @record.destroy
      unless handle_event(:destroy, :render)
        respond_to do |format|
          format.html { redirect_to(resource.index_path, notice: 'Record was successfully destroyed.') }
          format.json { head(:no_content) }
        end
      end
      handle_event(:destroy, :after)
    end

    private

    def record_params
      params.require(resource.klass.name.underscore.to_sym).permit(resource.permitted_params)
    end

    def set_record
      return if handle_event(:set_record, :override)

      @record = resource.klass.find(params[:id])
    end

    def set_resource
      @resource = resource
    end

    def handle_event(method_sym, event_sym, *args)
      [Admin4rails, resource].each do |parent|
        dsl = parent.dsl
        next unless dsl.controller?
        next unless dsl.controller.send(:"#{method_sym}?")
        next unless dsl.controller.send(method_sym).send(:"#{event_sym}?")
        value = instance_eval(&dsl.controller.send(method_sym).send(event_sym, args))
        return event_sym == :override ? true : value
      end
      false
    end
  end
end
