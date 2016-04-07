require 'rails_helper'

module Admin4rails
  RSpec.describe 'Custom forms', type: :feature do
    let(:admin_user) do
      FactoryGirl.create(:admin_user)
    end

    before(:example) { login_as(admin_user, scope: :admin_user) }

    context 'Edit form' do
      it 'has the right fields' do
        visit Admin4rails::Engine.routes.url_helpers.edit_admin_user_path(admin_user.id)

        expect(page).not_to have_selector('#admin_user_id')
        expect(page).not_to have_selector('#admin_user_last_sign_in_at')
        expect(page).not_to have_selector('#admin_user_sign_in_count')

        expect(page).to have_selector('#admin_user_name')
        expect(page).to have_selector('#admin_user_surname')
        expect(page).to have_selector('#admin_user_email')
      end
    end

    context 'New form' do
      it 'has the right fields' do
        visit Admin4rails::Engine.routes.url_helpers.new_admin_user_path

        expect(page).not_to have_selector('#admin_user_id')
        expect(page).not_to have_selector('#admin_user_last_sign_in_at')
        expect(page).not_to have_selector('#admin_user_sign_in_count')

        expect(page).to have_selector('#admin_user_name')
        expect(page).to have_selector('#admin_user_surname')
        expect(page).to have_selector('#admin_user_email')
        expect(page).to have_selector('#admin_user_password')
      end

      it 'has passsword confirmation field' do
        visit Admin4rails::Engine.routes.url_helpers.new_admin_user_path

        expect(page).to have_selector('#admin_user_password_confirmation')
      end
    end

    context 'Show page' do
      it 'has the right fields' do
        visit Admin4rails::Engine.routes.url_helpers.admin_user_path(admin_user.id)

        expect(page).not_to have_selector('tr td.show_key', text: 'Id')
        expect(page).not_to have_selector('tr td.show_value', text: admin_user.id)
        expect(page).not_to have_selector('tr td.show_key', text: 'Updated at')
        expect(page).not_to have_selector('tr td.show_value', text: admin_user.updated_at)

        expect(page).to have_selector('tr td.show_key', text: 'Created at')
        expect(page).to have_selector('tr td.show_value', text: admin_user.created_at)
        expect(page).to have_selector('tr td.show_key', text: 'Name')
        expect(page).to have_selector('tr td.show_value', text: admin_user.name)
        expect(page).to have_selector('tr td.show_key', text: 'Surname')
        expect(page).to have_selector('tr td.show_value', text: admin_user.surname)
      end
    end
  end
end
