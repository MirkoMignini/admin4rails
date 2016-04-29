require 'rails_helper'

module Admin4rails
  RSpec.describe 'i18n features', type: :feature do
    before(:example) do
      login_as(FactoryGirl.create(:admin_user), scope: :admin_user)
    end

    context 'Helpers' do
      it 'has right title and description in index' do
        visit Admin4rails::Engine.routes.url_helpers.admin_users_path
        expect(page).to have_selector('h1', text: 'Administrators complete list')
        expect(page).to have_selector('h1 small', text: 'adminz rulez')
      end

      it 'has right title and description in show' do
        visit Admin4rails::Engine.routes.url_helpers.admin_user_path(AdminUser.first.id)
        expect(page).to have_selector('h1', text: 'Administrator')
        expect(page).to have_selector('h1 small', text: '')
      end
    end

    context 'Activerecord i18n' do
      it 'has the sidebar items' do
        visit Admin4rails::Engine.routes.url_helpers.admin_users_path
        expect(page).to have_selector("li a[href='/admin4rails/admin_users']", text: 'Administrators')
      end
    end
  end
end
