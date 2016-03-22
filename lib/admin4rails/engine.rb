module Admin4rails
  class Engine < ::Rails::Engine
    isolate_namespace Admin4rails

    config.generators do |g|
      g.test_framework :rspec
    end
  end
end
