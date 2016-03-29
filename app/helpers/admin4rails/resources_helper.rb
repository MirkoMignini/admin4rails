module Admin4rails
  module ResourcesHelper
    def get_icon(resource)
      return resource.dsl.icon if resource.dsl.icon?
      'fa-th'
    end
  end
end
