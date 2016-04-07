require 'rails_helper'
require 'admin4rails/utility'

module Admin4rails
  RSpec.describe 'Utility' do
    context '#compare' do
      def compare(x, y)
        Admin4rails::Utility.compare(x, y)
      end

      it 'compares symbol with symbol' do
        expect(compare(:test, :test)).to eq(true)
        expect(compare(:test, :test2)).to eq(false)
      end

      it 'compares string with symbol' do
        expect(compare(:test, 'test')).to eq(true)
        expect(compare('test', :test)).to eq(true)
        expect(compare(:test2, 'test')).to eq(false)
        expect(compare('test', :test2)).to eq(false)
      end

      it 'compares string with string' do
        expect(compare('test', 'test')).to eq(true)
        expect(compare('test2', 'test')).to eq(false)
      end

      it 'raises an error if wrong arguments' do
        expect { compare('test', Object.new) }.to raise_error(ArgumentError)
      end
    end
  end
end
