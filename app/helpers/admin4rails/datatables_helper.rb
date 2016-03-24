module Admin4rails
  module DatatablesHelper
    def get_datatable(resource, id)
      content_tag(:table, id: id, class: 'table table-bordered table-hover') do
        content_tag(:thead) do
          content_tag(:tr) do
            resource.attributes.each do |attribute|
              concat(content_tag(:th) { attribute.display_text })
            end
            concat(content_tag(:th, 'Actions'))
          end
        end
      end
    end

    def get_datatable_columns(resource)
      resource.attributes.map{ |attribute| {data: attribute.name} }.concat([data: 'Actions']).to_json
    end
  end
end
