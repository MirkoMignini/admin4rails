require 'rails_helper'

module Admin4rails
  RSpec.describe 'Index', type: :feature do
    before(:example) do
      login_as(FactoryGirl.create(:admin_user), scope: :admin_user)
      visit Admin4rails::Engine.routes.url_helpers.posts_path
    end

    context 'Path' do
      it 'goes to posts index' do
        expect(page).to have_current_path(Admin4rails::Engine.routes.url_helpers.posts_path)
      end
    end

    context 'Header' do
      it 'has right title and description' do
        expect(page).to have_selector('h1', text: 'Posts list')
        expect(page).to have_selector('h1 small', text: '')
      end
    end

    context 'Content' do
      before(:context) do
        create_list(:post, 50)
      end

      context 'Datagrid' do
        it 'has the datagrid' do
          expect(page).to have_selector('table.table')
        end

        it 'has the total records label' do
          expect(page).to have_selector('.dataTables_info', text: '50 records')
        end

        it 'has the pager' do
          expect(page).to have_selector('.dataTables_paginate')
        end
      end

      context 'Pager' do
        it 'is at page 1 by default' do
          expect(page).to have_selector('ul.pagination li.active', text: '1')
          expect(page).to have_selector('td.id', text: '1')
        end

        it 'goes to page 2' do
          page.first("a[href='/admin4rails/posts?page=2']").click
          expect(page).to have_selector('ul.pagination li.active', text: '2')
          expect(page).to have_selector('td.id', text: '26')
        end
      end

      context 'Actions' do
        context 'New' do
          let(:button_text) { 'Create Post' }

          it 'has the right label' do
            expect(page).to have_selector('a.btn.btn-primary', text: button_text)
          end

          it 'goes to new page' do
            click_link(button_text)
            expect(page).to have_current_path(Admin4rails::Engine.routes.url_helpers.new_post_path)
          end
        end

        context 'Edit' do
          let(:button_text) { 'Edit' }

          it 'has the right label' do
            expect(page).to have_selector('ul.dropdown-menu li a', text: button_text)
          end

          it 'goes to edit page' do
            page.first("a[href='/admin4rails/posts/1/edit']").click
            expect(page).to have_current_path(Admin4rails::Engine.routes.url_helpers.edit_post_path(1))
          end
        end

        context 'Show' do
          let(:button_text) { 'Show' }

          it 'has the right label' do
            expect(page).to have_selector('ul.dropdown-menu li a', text: button_text)
          end

          it 'goes to show page' do
            page.first("a[href='/admin4rails/posts/1']").click
            expect(page).to have_current_path(Admin4rails::Engine.routes.url_helpers.post_path(1))
          end
        end

        context 'Delete' do
          let(:button_text) { 'Delete' }

          it 'has the right label' do
            expect(page).to have_selector('ul.dropdown-menu li a', text: button_text)
          end

          it 'deletes the record' do
            expect do
              page.first("a[href='/admin4rails/posts/1'][text()='Delete']").click
            end.to change { Post.all.count }.by(-1)
          end
        end
      end
    end
  end
end
