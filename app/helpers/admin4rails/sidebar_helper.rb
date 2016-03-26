module Admin4rails
  module SidebarHelper
    def sidebar
      content_tag(:ul, class: 'sidebar-menu') do
        Admin4rails.sidebar.layout.all_nodes.each do |node|
          case node.name.to_s
          when 'header' then concat(header(node))
          when 'resources' then resources(node)
          end
        end
      end
    end

    def header(node)
      content_tag(:li, class: 'header') do
        node[:text].upcase
      end
    end

    def resources(_node)
      Admin4rails.resources.each do |res|
        concat(resource(res))
      end
    end

    def resource(res)
      content_tag(:li) do
        link_to(res.index_path) do
          content_tag(:i, class: "fa #{get_icon(res)}") {} +
            content_tag(:span) { res.model_name.pluralize.humanize }
        end
      end
    end
  end
end
