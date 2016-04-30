module Admin4rails
  module DashboardHelper
    def widget_counter(options)
      render partial: 'admin4rails/dashboard/widget_counter', locals: { options: options }
    end
  end
end
