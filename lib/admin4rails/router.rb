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
      if resource.dsl.member_action?
        member do
          put resource.dsl.member_action[:method] if resource.dsl.member_action[:verb] == :put
        end
        # TODO
      end
    end
  end
end
