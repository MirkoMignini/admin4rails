module Admin4rails
  class Router
    def initialize(application)
      @application = application
    end

    def setup_routes!
      dsl_resources = @application.dsl.resources
      Admin4rails::Engine.routes.draw do
        dsl_resources.each do |resource|
          resources resource[:class].name.underscore.pluralize.to_sym, controller: 'resources'
        end
        root to: 'application#home'
      end
    end
  end
end
