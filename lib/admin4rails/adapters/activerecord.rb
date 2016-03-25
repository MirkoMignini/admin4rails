module Admin4rails
  module Adapters
    module ActiveRecord
      def all
        klass.all
      end

      private

      def create_attributes
        @attributes = []
        @klass.columns.each do |column|
          @attributes << Attribute.new(self, column)
        end
      end
    end
  end
end
