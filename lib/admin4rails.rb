require 'hamlit'
require 'easydsl'
require 'font-awesome-rails'
require 'sass-rails'
require 'bootstrap-sass'
require 'datagrid'

require 'admin4rails/engine'
require 'admin4rails/router'
require 'admin4rails/resource'

module Admin4rails
  def self.initialize!
    load_all_files
    init_resources
    @router = Admin4rails::Router.new(self)
    setup_reloader if Rails.env.development?
  end

  def self.setup(&block)
    @dsl = Easydsl.define(&block)
  end

  def self.method_missing(method_symbol, *args, &block)
    @dsl.send(method_symbol, args)
  end

  def self.setup_routes!
    @router.setup_routes!
  end

  def self.dsl
    @dsl
  end

  def self.resources
    @resources ||= []
  end

  private

  def self.setup_reloader
    reloader = ActiveSupport::FileUpdateChecker.new(admin_files) do
      puts 'Admin4Rails reload!'
      load_all_files
      init_resources
      setup_routes!
    end
    ActionDispatch::Reloader.to_prepare do
      reloader.execute_if_updated
    end
  end

  def self.init_resources
    resources.clear
    dsl.resources.each do |resource|
      resources << Resource.new(resource)
    end
  end

  def self.admin_files
    Dir[File.expand_path('app/admin/**/*', Rails.root)]
  end

  def self.load_all_files
    admin_files.each { |file| load(file) }
  end
end
