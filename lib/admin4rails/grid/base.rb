module Admin4rails
  module Grid
    module Base
      class << self
        def included(base)
          setup_scope(base)
          setup_columns(base)
          setup_actions(base)
        end

        def setup_scope(base)
          base.class_eval do
            scope do
              resource.klass unless resource.handle_event(self, 'scope')
            end
          end
        end

        def setup_columns(base)
          attributes = get_attributes(base.resource)
          base.class_eval do
            unless resource.handle_event(self, 'columns')
              resource.handle_event(self, 'columns_prepend')
              attributes.each { |attribute| column(attribute.name.to_sym) }
              resource.handle_event(self, 'columns_append')
            end
          end
        end

        def get_attributes(resource)
          if resource.dsl.index? && resource.dsl.index.fields?
            resource.filter_attributes(resource.dsl.index.fields)
          else
            resource.attributes
          end
        end

        def setup_actions(base)
          base.class_eval do
            column('', html: true) do |record|
              render partial: 'datagrid/dropdown_actions', locals: { record: record, resource: @resource }
            end
          end
        end
      end
    end
  end
end
