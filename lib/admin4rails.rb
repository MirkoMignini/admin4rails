require 'admin4rails/engine'
require 'hamlit'
require 'easydsl'
require 'font-awesome-rails'

module Admin4rails
  def self.initialize!
    load_all_files
    setup_reloader if Rails.env.development?
  end

  def self.setup(&block)
    @dsl = Easydsl.define(&block)
  end

  def self.method_missing(method_symbol, *args, &block)
    @dsl.send(method_symbol, args)
  end

  private

  def self.setup_reloader
    reloader = ActiveSupport::FileUpdateChecker.new(admin_files) do
      puts 'Admin4Rails reload!'
      load_all_files
    end
    ActionDispatch::Reloader.to_prepare do
      reloader.execute_if_updated
    end
  end

  def self.admin_files
    Dir[File.expand_path('app/admin/**/*', Rails.root)]
  end

  def self.load_all_files
    admin_files.each { |file| load(file) }
  end
end
