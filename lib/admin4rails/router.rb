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
          #  next if resource.belongs_to.nil?
          draw_routes(resource.model_name.underscore.pluralize.to_sym, resource)
        end
        root to: 'application#home'
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
        draw_associations_routes(resource) unless resource.nil?
      end
    end
  end
end
