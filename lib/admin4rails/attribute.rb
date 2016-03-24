module Admin4rails
  class Attribute
    attr_reader :resource, :type, :name, :display_text

    def initialize(resource, column)
      @resource = resource
      @type = column.sql_type
      @name = column.name
      @display_text = resource.klass.human_attribute_name(column.name)
    end
  end
end
