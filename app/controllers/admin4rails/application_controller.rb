module Admin4rails
  class ApplicationController < ActionController::Base
    def home
      render 'pages/admin4rails/home'
    end
  end
end
