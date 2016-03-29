module Admin4rails
  module Plugins
    module DataGrid
      module Grid
        def self.included(base)
          # base.extend ClassMethods
          base.class_eval do
            scope do
              resource.klass
            end

            resource.attributes.each do |attribute|
              column(attribute.name.to_sym)
            end

            column('', html: true) do |record|
              render partial: 'datagrid/dropdown_actions', locals: { record: record, resource: @resource }
            end
          end
        end
      end
    end
  end
end
