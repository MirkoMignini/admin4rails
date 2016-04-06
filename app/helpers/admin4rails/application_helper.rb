module Admin4rails
  module ApplicationHelper
    def alert_class_for(flash_type)
      {
        success: 'alert-success',
        error: 'alert-danger',
        alert: 'alert-warning',
        notice: 'alert-info',
      }[flash_type.to_sym] || flash_type.to_s
    end

    def icon_for(flash_type)
      {
        success: 'fa-check',
        error: 'fa-ban',
        alert: 'fa-warning',
        notice: 'fa-info',
      }[flash_type.to_sym] || flash_type.to_s
    end
  end
end
