module Admin4rails
  module I18nHelper
    def resource_label(view, attribute)
      t(attribute,
        scope: "#{@resource.klass.name.underscore.pluralize}.#{view}",
        default: t("default.models.#{view}.#{attribute}"),
        model: @resource.human,
        models: @resource.human_plural)
    end

    def grid_label(view, attribute)
      t(attribute,
        scope: "grid.#{view}",
        default: t("default.grid.#{view}.#{attribute}"))
    end
  end
end
