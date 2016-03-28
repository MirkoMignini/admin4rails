require 'rails_helper'

module Admin4rails
  RSpec.describe ResourcesController, type: :controller do
    routes { Admin4rails::Engine.routes }

    describe 'Dynamic controller creation' do
      it 'Creates the controller' do
        expect(Admin4rails.const_get('PostsController')).to be(Admin4rails::PostsController)
      end
    end

    describe 'routing' do
      it 'routes to index' do
        expect(get: '/posts').to route_to(controller: 'admin4rails/posts', action: 'index')
        expect(get: '/posts.json').to route_to(controller: 'admin4rails/posts', action: 'index', format: 'json')
      end
    end
  end
end
