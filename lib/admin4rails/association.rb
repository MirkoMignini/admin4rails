module Admin4rails
  class Association
    attr_reader :resource, :macro, :table_name, :foreign_key, :name

    def initialize(resource, ar_association)
      @resource = resource
      @name = ar_association.name.to_s
      @macro = ar_association.macro
      # @table_name = ar_association.table_name
      # @foreign_key = ar_association.foreign_key
    end

    def associated_resource
      Admin4rails.resource_from_table_name(@name)
    end
  end
end
