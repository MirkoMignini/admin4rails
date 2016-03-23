module Admin4rails
  module SidebarHelper
    def get_sidebar
      content_tag(:ul, class: 'sidebar-menu') do
        Admin4rails.sidebar.layout.all_nodes.each do |node|
          case node.name.to_s
          when 'header' then concat(get_header(node))
          when 'resources' then get_resources(node)
          end
        end
      end
    end

    def get_header(node)
      content_tag(:li, class: 'header') do
        node[:text].upcase
      end
    end

    def get_resources(node)
      Admin4rails.resources.each do |resource|
        concat(get_resource(resource))
      end
    end

    def get_resource(resource)
      content_tag(:li) do
        link_to(resource.plural_sym) do
          content_tag(:i, class: "fa #{resource.icon}") {} +
          content_tag(:span) { resource.plural_human }
        end.html_safe
      end
    end
  end
end
