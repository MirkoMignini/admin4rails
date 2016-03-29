require 'admin4rails/attribute'

module Admin4rails
  class Resource
    attr_reader :dsl, :klass

    def initialize(resource)
      init_adapter
      @dsl = resource
      @klass = resource[:class]
      create_controller
    end

    def model_name
      klass.name
    end

    def controller_name
      "#{klass.name.pluralize}Controller"
    end

    def controller_class
      Admin4rails.const_get("Admin4rails::#{controller_name}")
    end

    def all
      not_implemented
    end

    def attributes
      @attributes || setup_attributes
    end

    def edit_attributes
      attributes.delete_if{|attribute| standard_params.include?(attribute.name.to_sym) }
    end

    def permitted_params
      attributes.map { |attribute| attribute.name.to_sym } - standard_params
    end

    %w(index new edit show).each do |method|
      %w(path url).each do |suffix|
        define_method("#{method}_#{suffix}") do |*args|
          url = if method == 'index'
            "#{klass.name.underscore.pluralize}_#{suffix}"
          elsif method == 'show'
            "#{klass.name.underscore}_#{suffix}"
          else
            "#{method}_#{klass.name.underscore}_#{suffix}"
          end
          Admin4rails::Engine.routes.url_helpers.send(url.to_sym, *args)
        end
      end
    end

    private

    def init_adapter
      case Admin4rails.config.adapter
      when :activerecord
        require 'admin4rails/adapters/activerecord'
        extend Adapters::ActiveRecord
      when :mongoid
        require 'admin4rails/adapters/mongoid'
        extend Adapters::Mongoid
      else
        raise ArgumentError, "Unknown adapter #{Admin4rails.config.adapter}."
      end
    end

    def standard_params
      [:id, :_id, :created_at, :updated_at]
    end

    def create_controller
      eval "
        class Admin4rails::#{controller_name} < ResourcesController
          def self.resource=(res); @@resource = res end
          def resource; @@resource end
        end
      "
      controller_class.resource = self
    end

    def setup_attributes
      not_implemented
    end

    def not_implemented
      raise NotImplementedError, "Method #{__method__} must be implemented in adapter."
    end
  end
end
