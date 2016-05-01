module Admin4rails
  module SidebarHelper
    def sidebar
      content_tag(:ul, class: 'sidebar-menu') do
        Admin4rails.sidebar.layout.get_all_nodes.each do |node|
          case node.get_name.to_s
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
      concat(dashboard)
      Admin4rails.resources.each do |res|
        concat(resource(res)) if res.dsl.belongs_to.nil?
      end
    end

    def item(path, icon, text)
      content_tag(:li, class: ('active' if current_page?(path))) do
        link_to(path) do
          content_tag(:i, class: "fa #{icon}") {} +
            content_tag(:span) { text }
        end
      end
    end

    def resource(res)
      item(res.index_path, get_icon(res), res.klass.model_name.human(count: :many))
    end

    def dashboard
      item(root_path, 'fa-dashboard', 'Dashboard')
    end
  end
end
