module Admin4rails
  module FormHelper
    def form_fields(form)
      found_partial = nil
      ["#{@form_type}_fields", 'fields'].each do |partial|
        fields_partial = @resource.view_partial(partial)
        if lookup_context.template_exists?(fields_partial, nil, true)
          found_partial = fields_partial
          break
        end
      end
      if found_partial.nil?
        capture do
          @attributes.each do |attribute|
            if attribute.name.end_with?('_id')
              concat(form.association(attribute.name.gsub('_id', '').to_sym))
            else
              concat(form.input(attribute.name.to_sym))
            end
          end
        end
      else
        render(partial: found_partial, locals: { f: form })
      end
    end
  end
end
