module Admin4rails
  class ApplicationController < ActionController::Base
    before_action :authenticate_admin_user!

    def set_locale
      I18n.locale = params[:locale]
      redirect_to :back
    end
  end
end
