module Admin4rails
  module Grid
    module Base
      def self.included(base)
        base.class_eval do
          scope do
            grid_scope
          end
          grid_columns
          grid_actions
        end
      end
    end

    class GridParent
      class << self
        def resource=(res)
          @@resource = res
        end

        def resource
          @@resource
        end

        def fields
          @@resource.attributes.map(&:name)
        end

        def grid_scope
          @@resource.klass
        end

        def grid_columns
          @@resource.filter_attributes(fields).each do |attribute|
            column(attribute.name.to_sym)
          end
        end

        def grid_actions
          column('', html: true) do |record|
            render partial: 'datagrid/dropdown_actions', locals: { record: record, resource: @resource }
          end
        end
      end

      def resource
        @@resource
      end
    end
  end
end
