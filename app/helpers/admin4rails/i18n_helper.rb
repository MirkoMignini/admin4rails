module Admin4rails
  module I18nHelper
    def resource_label(view, attribute)
      t(attribute,
        scope: "#{@resource.klass.name.underscore.pluralize}.#{view}",
        default: t("default.models.#{view}.#{attribute}"),
        model: @resource.klass.model_name.human,
        models: @resource.klass.model_name.human(count: 2))
    end

    def grid_label(view, attribute)
      t(attribute,
        scope: "grid.#{view}",
        default: t("default.grid.#{view}.#{attribute}"))
    end
  end
end
