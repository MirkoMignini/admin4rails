require 'admin4rails/attribute'

module Admin4rails
  class Resource
    attr_reader :node, :klass, :attributes

    def initialize(resource)
      begin
        init_adapter
        @node = resource
        @klass = resource[:class]
        create_controller
        create_attributes
      rescue ActiveRecord::StatementInvalid
      end
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

    ['collection_', 'new_', 'edit_', ''].each do |method|
      %w(path url).each do |suffix|
        define_method("#{method}#{suffix}") do |*args|
          if method == 'collection_'
            url = "#{klass.name.underscore.pluralize}_#{suffix}"
          else
            url = "#{method}#{klass.name.underscore}_#{suffix}"
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
