module Admin4rails
  module FormHelper
    def form_fields(form)
      if @resource.dsl.send("#{@form_type}?".to_sym) && @resource.dsl.send(@form_type).custom?
        render(partial: @resource.dsl.send(@form_type).custom, locals: { f: form })
      else
        capture do
          @attributes.each do |attribute|
            concat(form.input(attribute.name.to_sym))
          end
        end
      end
    end
  end
end
