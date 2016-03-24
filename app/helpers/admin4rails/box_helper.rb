module Admin4rails
  module BoxHelper
    def box(&block)
      content_tag(:div, class: 'box') do
        capture(&block)
      end
    end

    def box_title(&block)
      content_tag(:div, class: 'box-header with-border') do
        content_tag(:h3, class: 'box-title') do
          capture(&block)
        end
      end
    end

    def box_body(&block)
      content_tag(:div, class: 'box-body') do
        capture(&block)
      end
    end

    def box_footer(&block)
      content_tag(:div, class: 'box-footer') do
        capture(&block)
      end
    end
  end
end
