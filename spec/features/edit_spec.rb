require 'rails_helper'

module Admin4rails
  RSpec.describe 'Edit', type: :feature do
    let(:post) do
      create(:post)
    end

    before(:example) do
      login_as(FactoryGirl.create(:admin_user), scope: :admin_user)
      visit Admin4rails::Engine.routes.url_helpers.edit_post_path(post.id)
    end

    context 'Header' do
      it 'has right title and description' do
        expect(page).to have_selector('h1', text: 'Post')
        expect(page).to have_selector('h1 small', text: '')
      end
    end

    context 'Content' do
      it 'contains the form' do
        expect(page).to have_selector("#edit_post_#{post.id}[@action='/admin4rails/posts/#{post.id}']")
        expect(page).to have_selector("#edit_post_#{post.id}[@method='post']")
      end

      it 'contains a editable form with standard attributes and value set' do
        expect(page).to have_selector("#post_title[@value='#{post.title}']")
        expect(page).to have_selector('#post_description', text: post.description)
      end

      it 'hides standard fields' do
        expect(page).not_to have_selector('#post_id')
        expect(page).not_to have_selector('#post_created_at')
        expect(page).not_to have_selector('#post_updated_at')
      end

      it 'contains submit button' do
        expect(page).to have_selector("input[@value='Update Post']")
      end
    end
  end
end
