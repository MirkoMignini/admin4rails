require 'rails_helper'

module Admin4rails
  RSpec.describe 'Show', type: :feature do
    let(:post) do
      create(:post)
    end

    before(:example) do
      visit Admin4rails::Engine.routes.url_helpers.post_path(post.id)
    end

    context 'Header' do
      it 'has right title and description' do
        expect(page).to have_selector('h1', text: 'Post')
        expect(page).to have_selector('h1 small', text: '')
      end
    end

    context 'Content' do
      it 'has the attributes grid' do
        expect(page).to have_selector('table.table')
      end

      it 'contains standard attributes' do
        expect(page).to have_selector('tr td.show_key', text: 'Id')
        expect(page).to have_selector('tr td.show_value', text: post.id)
        expect(page).to have_selector('tr td.show_key', text: 'Created at')
        expect(page).to have_selector('tr td.show_value', text: post.created_at)
        expect(page).to have_selector('tr td.show_key', text: 'Updated at')
        expect(page).to have_selector('tr td.show_value', text: post.updated_at)
      end

      it 'contains Post attributes' do
        expect(page).to have_selector('tr td.show_key', text: 'Title')
        expect(page).to have_selector('tr td.show_value', text: post.title)
        expect(page).to have_selector('tr td.show_key', text: 'Description')
        expect(page).to have_selector('tr td.show_value', text: post.description)
      end
    end
  end
end
