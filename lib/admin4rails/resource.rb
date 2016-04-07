require 'admin4rails/attribute'
require 'admin4rails/utility'
require 'admin4rails/grid/controller'

module Admin4rails
  class Resource
    attr_reader :dsl, :klass

    def initialize(resource)
      @dsl = resource
      @klass = resource[:class]
      init_adapter
      create_controller
      Admin4rails::Grid::Controller.create_controller(self)
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

    def attribute(name)
      attributes.find { |item| Admin4rails::Utility.compare(item.name, name) }
    end

    def edit_attributes
      attributes.reject { |attribute| standard_params.include?(attribute.name.to_sym) }
    end

    def filter_attributes(fields)
      results = []
      fields.each do |field|
        result = attribute(field)
        results << result unless result.nil?
      end
      results
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

    def handle_event(base, event_symbol, *args)
      [self, Admin4rails].each do |obj|
        cdsl = obj.dsl
        next unless cdsl.events?
        next unless cdsl.events.send(:"#{event_symbol}?")
        return base.instance_eval(&cdsl.events.send(event_symbol, args))
      end
      false
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
