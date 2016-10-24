require 'rails_helper'
require 'admin4rails/exporters/csv'

module Admin4rails
  RSpec.describe 'Exporters' do
    context 'CSV' do
      it 'exports records' do
        resource = Admin4rails.resources.first
        attributes = resource.attributes.map(&:name)
        expect(Exporters::Csv.export(resource, attributes, {})).not_to eq(nil)
      end
    end
  end
end
