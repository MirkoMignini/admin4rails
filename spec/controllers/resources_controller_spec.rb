require 'rails_helper'

module Admin4rails
  RSpec.describe ResourcesController, type: :controller do
    routes { Admin4rails::Engine.routes }

    describe 'Dynamic controller creation' do
      it 'creates the controller' do
        expect(Admin4rails.const_get('PostsController')).to be(Admin4rails::PostsController)
      end
    end

    describe 'Routing' do
      describe 'Html format' do
        it 'routes to index' do
          expect(get: '/posts').to route_to(controller: 'admin4rails/posts', action: 'index')
        end
      end

      describe 'Json format' do
        it 'routes to index' do
          expect(get: '/posts.json').to route_to(controller: 'admin4rails/posts', action: 'index', format: 'json')
        end
      end
    end
  end
end
