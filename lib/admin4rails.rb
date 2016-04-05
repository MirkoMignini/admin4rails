require 'hamlit'
require 'easydsl'
require 'font-awesome-rails'
require 'jquery-rails'
require 'sass-rails'
require 'bootstrap-sass'
require 'simple_form'
require 'cocoon'
require 'datagrid'
require 'kaminari'
require 'devise'

require 'admin4rails/engine'
require 'admin4rails/router'
require 'admin4rails/resource'

module Admin4rails
  class << self
    def initialize!
      load_all_files
      init_resources
      @router = Admin4rails::Router.new(self)
      setup_reloader if Rails.env.development?
      load_all_plugins
    end

    def setup(&block)
      dsl.define(&block)
    end

    def method_missing(method_symbol, *args)
      dsl.send(method_symbol, args)
    end

    def setup_routes!
      @router.setup_routes! if @router
    end

    def dsl
      @dsl ||= Easydsl.define {}
    end

    attr_writer :dsl

    def resources
      @resources ||= []
    end

    private

    def setup_reloader
      reloader = ActiveSupport::FileUpdateChecker.new(admin_files) do
        logger.info('Admin4Rails reload!')
        load_all_files
        init_resources
        setup_routes!
      end
      ActionDispatch::Reloader.to_prepare do
        reloader.execute_if_updated
      end
    end

    def init_resources
      resources.clear
      dsl.resources.each do |resource|
        resources << Resource.new(resource)
      end
    end

    def admin_files
      Dir[File.expand_path('app/admin/**/*', Rails.root)]
    end

    def load_all_files
      admin_files.each { |file| load(file) }
    end

    def plugin_files
      Dir[File.expand_path('lib/admin4rails/plugins/**/setup.rb', Admin4rails::Engine.root)]
    end

    def load_all_plugins
      plugin_files.each { |file| load(file) }
    end
  end
end
