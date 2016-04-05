module Admin4rails
  class Engine < ::Rails::Engine
    isolate_namespace Admin4rails

    config.generators do |g|
      g.test_framework :rspec
    end

    config.to_prepare do
      #Devise::SessionsController.layout 'devise'
    end
  end
end
