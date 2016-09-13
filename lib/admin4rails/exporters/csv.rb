module Admin4rails
  module Exporters
    require 'csv'

    module Csv
      def self.export(resource, params)
        resources = if resource.belongs_to_id.nil?
          resource.all
        else
          resource.klass.where(resource.belongs_to_id => params[resource.belongs_to_id])
        end

        attributes = resource.attributes.map(&:name)
        CSV.generate(headers: true) do |csv|
          csv << attributes
          resources.each do |record|
            csv << attributes.map{ |attr| record.send(attr) }
          end
        end
      end
    end
  end
end
