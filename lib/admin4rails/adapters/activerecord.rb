module Admin4rails
  module Adapters
    module ActiveRecord
      delegate :all, to: :klass

      private

      def setup_attributes
        @attributes = []
        @klass.columns.each do |column|
          @attributes << Attribute.new(self, column)
        end
        @attributes
      end
    end
  end
end
