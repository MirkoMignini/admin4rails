require 'rails_helper'

module Admin4rails
  RSpec.describe AdminUsersController, type: :controller do
    routes { Admin4rails::Engine.routes }

    let(:admin_user) { FactoryGirl.create(:admin_user) }

    before(:each) do
      @request.env['devise.mapping'] = Devise.mappings[:admin]
      sign_in admin_user
    end

    describe '#index' do
      before(:each) { get(:index) }

      it 'success' do
        expect(response).to be_success
      end

      it 'renders template' do
        expect(response).to render_template('index')
      end

      it 'assigns the resource to controller' do
        expect(assigns(:resource)).to be_kind_of(Resource)
      end

      it 'assigns posts to grid object' do
        expect(assigns(:grid)).not_to be_nil
      end

      it 'has custom fields' do
        expect(assigns(:resource).dsl.index.fields).to eq([:name, :surname, :email, :last_sign_in_at, :sign_in_count])
      end
    end
  end
end
