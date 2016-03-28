module Admin4rails
  RSpec.describe 'lib::Resource' do
    let(:post) do
      Admin4rails.resources.each do |resource|
        return resource if resource.klass == Post
      end
      return nil
    end

    describe 'Init resources' do
      it 'contains resource objects' do
        expect(Admin4rails.resources.count).to be > 0
      end
    end

    describe 'Post resource' do
      describe 'Controller' do
        it 'returns the controller name'  do
          expect(post.controller_name).to eq('PostsController')
        end

        it 'returns the controller class'  do
          expect(post.controller_class).to be(PostsController)
        end
      end

      describe 'Check Post resource' do
        it 'contains Post resource' do
          expect(post).not_to be_nil
        end

        it 'is binded to Post model class' do
          expect(post.klass).to be(Post)
        end
      end

      describe 'Path and urls' do
        it 'generates the paths helpers' do
          expect(post.index_path).to eq(Admin4rails::Engine.routes.url_helpers.posts_path)
        end
      end
    end
  end
end
