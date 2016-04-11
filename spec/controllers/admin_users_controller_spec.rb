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
    end

    describe '#show' do
      before(:each) { get(:show, id: admin_user.id) }

      it 'success' do
        expect(response).to be_success
      end

      it 'assigns the right attributes' do
        expect(assigns(:attributes).count).to eq(8)
      end
    end
  end
end
