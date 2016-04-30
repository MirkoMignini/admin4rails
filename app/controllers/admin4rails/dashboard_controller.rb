module Admin4rails
  class DashboardController < ApplicationController
    include ::DashboardController

    def show
      dashboard if respond_to?(:dashboard)
    end
  end
end
