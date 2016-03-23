module Admin4rails
  class Router
    def initialize(application)
      @application = application
    end

    def setup_routes!
      dsl_resources = @application.resources
      Admin4rails::Engine.routes.draw do
        dsl_resources.each do |resource|
          resources resource.plural_sym
        end
        root to: 'application#home'
      end
    end
  end
end
