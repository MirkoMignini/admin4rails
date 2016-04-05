require 'rails_helper'

module Admin4rails
  RSpec.describe PostsController, type: :controller do
    routes { Admin4rails::Engine.routes }

    before(:each) do
      @request.env['devise.mapping'] = Devise.mappings[:admin]
      sign_in FactoryGirl.create(:admin_user)
    end

    describe 'Events' do
      let(:resource) { Admin4rails.dsl.resources.select { |res| res[:class] == Post }.first }

      context '#index' do
        context 'Global' do
          it 'overrides' do
            Admin4rails.dsl.define do
              events { index_override ->(_sender) { @test = 'Global Index override' } }
            end
            get(:index)
            expect(assigns(:grid)).to be_nil
            expect(assigns(:test)).to eq('Global Index override')
            Admin4rails.dsl.get_nodes[:events].clear
          end

          it 'handles before and after events' do
            Admin4rails.dsl.define do
              events do
                index_before ->(_sender) { @tb = 'Global Index before' }
                index_after ->(_sender) { @ta = 'Global Index after' }
              end
            end
            get(:index)
            expect(assigns(:tb)).to eq('Global Index before')
            expect(assigns(:ta)).to eq('Global Index after')
            Admin4rails.dsl.get_nodes[:events].clear
          end

          it 'handles the renderer that returns false' do
            Admin4rails.dsl.define do
              events do
                index_render(lambda do |_sender|
                  @test = 'Custom render false'
                  false
                end)
              end
            end
            get(:index)
            expect(assigns(:grid)).not_to be_nil
            expect(assigns(:test)).to eq('Custom render false')
            Admin4rails.dsl.get_nodes[:events].clear
          end

          it 'handles the renderer that returns true' do
            Admin4rails.dsl.define do
              events do
                index_render(lambda do |_sender|
                  @test = 'Custom render true'
                  true
                end)
              end
            end
            get(:index)
            expect(assigns(:grid)).to be_nil
            expect(assigns(:test)).to eq('Custom render true')
            Admin4rails.dsl.get_nodes[:events].clear
          end

          it 'handles grid custom columns' do
            Admin4rails.dsl.define do
              events do
                columns(lambda do |_sender|
                  column('', html: true) do |_record|
                    'custom'
                  end
                  true
                end)
              end
            end
            get(:index)
            expect(assigns(:grid)).not_to be_nil
            Admin4rails.dsl.get_nodes[:events].clear
          end
        end

        context 'Resource based' do
          it 'overrides' do
            resource.define do
              events do
                index_override ->(_sender) { @test = 'Resource Index override' }
              end
            end
            get(:index)
            expect(assigns(:grid)).to be_nil
            expect(assigns(:test)).to eq('Resource Index override')
            resource.get_nodes[:events].clear
          end

          it 'handles before and after events' do
            resource.define do
              events do
                index_before ->(_sender) { @tb = 'Resource Index before' }
                index_after ->(_sender) { @ta = 'Resource Index after' }
              end
            end
            get(:index)
            expect(assigns(:tb)).to eq('Resource Index before')
            expect(assigns(:ta)).to eq('Resource Index after')
            resource.get_nodes[:events].clear
          end

          it 'handles the renderer that returns false' do
            resource.define do
              events do
                index_render(lambda do |_sender|
                  @test = 'Resource Custom render false'
                  false
                end)
              end
            end
            get(:index)
            expect(assigns(:grid)).not_to be_nil
            expect(assigns(:test)).to eq('Resource Custom render false')
            resource.get_nodes[:events].clear
          end

          it 'handles the renderer that returns true' do
            resource.define do
              events do
                index_render(lambda do |_sender|
                  @test = 'Resource Custom render true'
                  true
                end)
              end
            end
            get(:index)
            expect(assigns(:grid)).to be_nil
            expect(assigns(:test)).to eq('Resource Custom render true')
            resource.get_nodes[:events].clear
          end
        end
      end
    end
  end
end
