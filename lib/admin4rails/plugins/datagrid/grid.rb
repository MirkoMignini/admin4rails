module Admin4rails
  module Plugins
    module DataGrid
      module Grid
        extend ActiveSupport::Concern
        
        included do
          scope do
            resource.klass
          end

          resource.attributes.each do |attribute|
            column(attribute.name.to_sym)
          end
        end
      end
    end
  end
end
