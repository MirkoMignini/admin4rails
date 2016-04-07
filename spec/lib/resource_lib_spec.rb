require 'rails_helper'

module Admin4rails
  RSpec.describe 'Resource' do
    let(:post_resource) do
      Admin4rails.resources.each do |resource|
        return resource if resource.klass == Post
      end
      return nil
    end

    let(:post) do
      create(:post)
    end

    let(:post_title_attribute) do
      post_resource.attributes.each do |attribute|
        return attribute if attribute.name == 'title'
      end
    end

    describe 'Init resources' do
      it 'contains resource objects' do
        expect(Admin4rails.resources.count).to be > 0
      end
    end

    describe 'Post resource' do
      describe 'Controller' do
        it 'returns the controller name' do
          expect(post_resource.controller_name).to eq('PostsController')
        end

        it 'returns the controller class' do
          expect(post_resource.controller_class).to be(PostsController)
        end
      end

      describe 'Check Post resource' do
        it 'contains Post resource' do
          expect(post_resource).not_to be_nil
        end

        it 'is binded to Post model class' do
          expect(post_resource.klass).to be(Post)
        end
      end

      describe 'Dynamic path and urls' do
        it 'generates the paths helpers' do
          expect(post_resource.index_path).to eq(Engine.routes.url_helpers.posts_path)
          expect(post_resource.new_path).to eq(Engine.routes.url_helpers.new_post_path)
          expect(post_resource.edit_path(post)).to eq(Engine.routes.url_helpers.edit_post_path(post))
          expect(post_resource.show_path(post)).to eq(Engine.routes.url_helpers.post_path(post))
        end

        it 'generates the urls helpers' do
          expect(post_resource.index_url).to eq(Engine.routes.url_helpers.posts_url)
          expect(post_resource.new_url).to eq(Engine.routes.url_helpers.new_post_url)
          expect(post_resource.edit_url(post)).to eq(Engine.routes.url_helpers.edit_post_url(post))
          expect(post_resource.show_url(post)).to eq(Engine.routes.url_helpers.post_url(post))
        end
      end

      describe 'Attributes' do
        it 'creates attributes' do
          expect(post_resource.attributes.count).to be > 0
        end

        it 'get attributes by name' do
          expect(post_resource.attribute(:id)).not_to be_nil
          expect(post_resource.attribute('id')).not_to be_nil
          expect(post_resource.attribute(:abc)).to be_nil
        end

        context 'Check post title attribute' do
          it 'checks if attribute exists' do
            expect(post_title_attribute).not_to be_nil
          end

          it 'checks attribute parameters' do
            expect(post_title_attribute.resource).to be(post_resource)
            expect(post_title_attribute.type).to eq('varchar')
            expect(post_title_attribute.name).to eq('title')
            expect(post_title_attribute.display_text).to eq('Title')
          end
        end
      end

      describe 'Filter attributes' do
        it 'filters attributes' do
          attributes = post_resource.filter_attributes([:description, :title])
          expect(attributes.count).to eq(2)
          expect(attributes.first.name).to eq('description')
          expect(attributes.last.name).to eq('title')
        end
      end

      describe 'Permitted params' do
        it 'returns the permitted params' do
          expect(post_resource.permitted_params).to eq([:title, :description])
        end
      end
    end
  end
end
