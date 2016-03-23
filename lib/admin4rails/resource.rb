module Admin4rails
  class Resource
    attr_reader :node, :klass

    def initialize(resource)
      @node = resource
      @klass = resource[:class]
      create_controller
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
      klass.all
    end

    private

    def create_controller
      eval "class Admin4rails::#{controller_name} < ResourcesController; end"
      controller_class.resource = self
    end
  end
end
