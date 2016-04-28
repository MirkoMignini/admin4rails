module Admin4rails
  module FormHelper
    def form_fields(form)
      fields_partial = @resource.view_partial(@form_type.to_s, 'fields')
      if lookup_context.template_exists?(fields_partial, nil, true)
        render(partial: fields_partial, locals: { f: form })
      else
        capture do
          @attributes.each do |attribute|
            if attribute.name.end_with?('_id')
              concat(form.association(attribute.name.gsub('_id', '').to_sym))
            else
              concat(form.input(attribute.name.to_sym))
            end
          end
        end
      end
    end
  end
end
