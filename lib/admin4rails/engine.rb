module Admin4rails
  class Engine < ::Rails::Engine
    isolate_namespace Admin4rails

    config.generators do |g|
      g.test_framework :rspec
    end

    config.to_prepare do
      Devise::SessionsController.layout 'admin4rails/devise'
    end

    config.after_initialize do
      Rails.logger.info 'Admin4rails initializing...'
      Admin4rails.initialize!
      Rails.logger.info 'Admin4rails initialized'
    end
  end
end
