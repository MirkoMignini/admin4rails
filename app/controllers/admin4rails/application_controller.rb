module Admin4rails
  class ApplicationController < ActionController::Base
    before_action :authenticate_admin_user!

    def home
      render 'pages/admin4rails/home'
    end
  end
end
