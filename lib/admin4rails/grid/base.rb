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
              resource.klass
            end
          end
        end

        def setup_columns(base)
          base.class_eval do
            resource.attributes.each do |attribute|
              column(attribute.name.to_sym)
            end
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
