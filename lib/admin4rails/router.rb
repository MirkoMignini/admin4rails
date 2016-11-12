module Admin4rails
  class Router
    def initialize(application)
      @application = application
    end

    def setup_routes!
      dsl_resources = @application.resources
      Admin4rails::Engine.routes.draw do
        extend RouterHelpers
        dsl_resources.each do |resource|
          next unless resource.belongs_to.nil?
          draw_routes(resource.plural_sym, resource)
        end
        put '/set_locale', to: 'application#set_locale'
        root to: 'dashboard#show'
      end
    end
  end

  module RouterHelpers
    def draw_associations_routes(resource)
      resource.associations.each do |association|
        draw_routes(association.name.to_sym, association.associated_resource)
      end
    end

    def draw_routes(route_symbol, resource)
      resources route_symbol do
        draw_custom_routes(resource) unless resource.nil?
        draw_associations_routes(resource) unless resource.nil?
      end
    end

    def draw_custom_routes(resource)
      draw_member_actions(resource) if resource.dsl.member_actions.count > 0
      draw_collection_actions(resource) if resource.dsl.collection_actions.count > 0
    end

    def draw_member_actions(resource)
      member do
        resource.dsl.member_actions.each do |member_action|
          send(member_action[:verb], member_action[:method])
        end
      end
    end

    def draw_collection_actions(resource)
      collection do
        resource.dsl.collection_actions.each do |_collection_action|
          send(member_action[:verb], member_action[:method])
        end
      end
    end
  end
end
