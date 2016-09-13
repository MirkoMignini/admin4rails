module Admin4rails
  module RoutingHelper
    def index_path(format = nil)
      url = url_for(@parent_records + [@resource.model_name.underscore.pluralize])
      url = "#{url}.#{format.to_s}" unless format.nil?
    end

    def new_path
      [:new] + @parent_records + [@resource.model_name.underscore]
    end

    def edit_path(record)
      [:edit] + @parent_records + [record]
    end

    def show_path(record)
      @parent_records + [record]
    end

    def delete_path(record)
      @parent_records + [record]
    end

    def form_path
      @parent_records + [@record]
    end
  end
end
