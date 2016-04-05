require 'rails_helper'

module Admin4rails
  RSpec.describe PostsController, type: :controller do
    routes { Admin4rails::Engine.routes }

    let(:posts) { create_list(:post, 4) }
    let(:post_object) { posts[rand 4] }

    before(:each) do
      @request.env['devise.mapping'] = Devise.mappings[:admin]
      sign_in FactoryGirl.create(:admin_user)
    end

    describe '#index' do
      before(:each) { get(:index) }

      it 'success' do
        expect(response).to be_success
      end

      it 'renders template' do
        expect(response).to render_template('index')
      end

      it 'assigns the resource to controller' do
        expect(assigns(:resource)).to be_kind_of(Resource)
      end

      it 'assigns posts to grid object' do
        expect(assigns(:grid)).not_to be_nil
      end
    end

    describe '#show' do
      before(:each) { get(:show, id: post_object.id) }

      it 'success' do
        expect(response).to be_success
      end

      it 'renders template' do
        expect(response).to render_template('show')
      end

      it 'assigns the resource to controller' do
        expect(assigns(:resource)).to be_kind_of(Resource)
      end

      it 'assigns it to @record' do
        expect(assigns(:record)).to eq(post_object)
      end
    end

    describe '#create' do
      context 'when valid' do
        let(:post_attributes) { attributes_for(:post) }

        it 'creates a new post' do
          expect do
            post(:create, post: post_attributes)
          end.to change { Post.count }.by(1)
        end

        it 'redirect to the new post after creation' do
          post(:create, post: post_attributes)
          expect(response).to redirect_to(Post.last)
        end

        it 'assigns the resource to controller' do
          post(:create, post: post_attributes)
          expect(assigns(:resource)).to be_kind_of(Resource)
        end

        it 'saves and assigns new post to @record' do
          post(:create, post: post_attributes)
          expect(assigns(:record)).to be_kind_of ActiveRecord::Base
          expect(assigns(:record)).to be_persisted
        end
      end

      context 'when invalid' do
        let(:post_attributes) { attributes_for(:post_invalid) }

        it "doesn't create a new post" do
          expect do
            post(:create, post: post_attributes)
          end.to change { Post.count }.by(0)
        end

        it 'renders new page again' do
          post(:create, post: post_attributes)
          expect(response).to render_template('new')
        end

        it 'assigns the resource to controller' do
          post(:create, post: post_attributes)
          expect(assigns(:resource)).to be_kind_of(Resource)
        end

        it 'assigns post to @post' do
          post(:create, post: post_attributes)
          expect(assigns(:record)).to be_kind_of ActiveRecord::Base
        end
      end
    end

    describe '#update' do
      let(:post) { create(:post) }
      before(:each) { put(:update, id: post.id, post: new_values) }

      context 'when valid' do
        let(:new_values) { attributes_for(:post) }

        it 'success' do
          expect(response).to redirect_to(post)
        end

        it 'saves and assigns post to @post' do
          expect(assigns(:record)).to eq(post)
        end

        it 'assigns the resource to controller' do
          expect(assigns(:resource)).to be_kind_of(Resource)
        end

        it 'saves updates' do
          expect { post.reload }.to change { post.title }.to(new_values[:title])
        end
      end

      context 'when invalid' do
        let(:new_values) { attributes_for(:post_invalid) }

        it 'renders edit page again' do
          expect(response).to render_template('edit')
        end

        it 'assigns post to @post' do
          expect(assigns(:record)).to eq(post)
        end
      end
    end

    describe '#destroy' do
      context 'when requested post exists' do
        before(:each) { delete(:destroy, id: post_object.id) }

        it 'success' do
          expect(response).to redirect_to(posts_path)
        end

        it 'assigns the resource to controller' do
          expect(assigns(:resource)).to be_kind_of(Resource)
        end

        it 'removes post form DB' do
          expect { post_object.reload }.to raise_exception(ActiveRecord::RecordNotFound)
        end
      end

      context 'when requested post does not exists' do
        it 'throws ActiveRecord::RecordNotFound' do
          expect { delete :destroy, id: -1 }.to raise_exception(ActiveRecord::RecordNotFound)
        end
      end
    end
  end
end
