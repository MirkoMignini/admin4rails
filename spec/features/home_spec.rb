require 'rails_helper'

module Admin4rails
  RSpec.describe 'Homepage', type: :feature do
    before(:example) do
      login_as(FactoryGirl.create(:admin_user), scope: :admin_user)
      visit Admin4rails::Engine.routes.url_helpers.root_path
    end

    it 'goes to Homepage' do
      expect(page).to have_current_path(Admin4rails::Engine.routes.url_helpers.root_path)
    end

    it 'has page title Admin4rails' do
      expect(page.title).to eq(Admin4rails.config.title)
    end

    context 'Sidebar' do
      it 'has the sidebar items' do
        expect(page).to have_selector("li a[href='/admin4rails/posts']", text: 'Posts')
        expect(page).to have_selector("li a[href='/admin4rails/admin_users']", text: 'Adminusers')
      end

      it 'has the dashboard item' do
        expect(page).to have_selector("li a[href='/admin4rails/']", text: 'Dashboard')
      end

      it 'has the current page selected' do
        expect(page).to have_selector("li.active a[href='/admin4rails/']", text: 'Dashboard')
      end
    end
  end
end
