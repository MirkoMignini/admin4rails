require 'rails_helper'

module Admin4rails
  RSpec.describe 'New', type: :feature do
    let(:post) do
      create(:post)
    end

    before(:example) do
      visit Admin4rails::Engine.routes.url_helpers.new_post_path
    end

    context 'Header' do
      it 'has right title and description' do
        expect(page).to have_selector('h1', text: 'Post')
        expect(page).to have_selector('h1 small', text: '')
      end
    end

    context 'Content' do
      it 'contains the form' do
        expect(page).to have_selector("#new_post[@action='/admin4rails/posts']")
        expect(page).to have_selector("#new_post[@method='post']")
      end

      it 'contains standard fields' do
        expect(page).to have_selector('#post_title')
        expect(page).to have_selector('#post_description', text: '')
      end

      it 'hides standard fields' do
        expect(page).not_to have_selector('#post_id')
        expect(page).not_to have_selector('#post_created_at')
        expect(page).not_to have_selector('#post_updated_at')
      end

      it 'contains submit button' do
        expect(page).to have_selector("input[@value='Create Post']")
      end
    end
  end
end
