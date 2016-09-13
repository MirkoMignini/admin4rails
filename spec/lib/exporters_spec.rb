require 'rails_helper'
require 'admin4rails/exporters/csv'

module Admin4rails
  RSpec.describe 'Exporters' do
    context 'CSV' do
      it 'exports records' do
        expect(Exporters::Csv.export(Admin4rails.resources.first, {})).not_to eq(nil)
      end
    end
  end
end
