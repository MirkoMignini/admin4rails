module Admin4rails
  module ResourcesHelper
    def get_icon(resource)
      return resource.node.icon if resource.node.icon?
      'fa-th'
    end
  end
end
