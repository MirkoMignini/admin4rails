module Admin4rails
  module Adapters
    module ActiveRecord
      delegate :all, to: :klass

      private

      def setup_attributes
        attributes = []
        # @attributes = ActiveSupport::HashWithIndifferentAccess.new
        @klass.columns.each do |column|
          attributes << Attribute.new(self, column)
        end
        attributes
      end

      def setup_associations
        associations = []
        @klass.reflections.keys.each do |key|
          ar_association = @klass.reflections[key]
          if ar_association.macro == :has_many
            associations << Association.new(self, ar_association)
          end
        end
        associations
      end
    end
  end
end
