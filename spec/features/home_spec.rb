require 'spec_helper'

module Admin4rails
  RSpec.describe 'Homepage', type: :feature do
    it 'goes to Homepage' do
      visit Admin4rails::Engine.routes.url_helpers.root_path
      expect(page).to have_current_path(Admin4rails::Engine.routes.url_helpers.root_path)
    end

    it 'has page title Admin4rails' do
      visit Admin4rails::Engine.routes.url_helpers.root_path
      expect(page.title).to eq(Admin4rails.config.title)
      expect(page).to have_content 'Posts'
    end
  end
end
