require 'admin4rails/attribute'

module Admin4rails
  class Resource
    attr_reader :node, :klass, :attributes

    def initialize(resource)
      init_adapter
      @node = resource
      @klass = resource[:class]
      create_controller
      create_attributes
    end

    def plural_sym
      klass.name.underscore.pluralize.to_sym
    end

    def plural_string
      klass.name.pluralize
    end

    def plural_human
      klass.name.pluralize.humanize
    end

    def path
      "/admin4rails/#{klass.name.underscore.pluralize}"
    end

    def controller_name
      "#{klass.name.pluralize}Controller"
    end

    def controller_class
      Admin4rails.const_get("Admin4rails::#{controller_name}")
    end

    def icon
      return node.icon if node.icon?
      'fa-th'
    end

    def all
      raise NotImplementedError, "Method #{__method__.to_s} must be implemented in adapter."
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

    def create_controller
      eval %{
        class Admin4rails::#{controller_name} < ResourcesController
          def self.resource=(res); @@resource = res end
          def resource; @@resource end
        end
      }
      controller_class.resource = self
    end

    def create_attributes
      not_implemented
    end

    def not_implemented
      raise NotImplementedError, "Method #{__method__.to_s} must be implemented in adapter."
    end
  end
end
