module Admin4rails
  module RoutingHelper
    def index_path
      @parent_records + [resource.model_name.underscore.pluralize]
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
