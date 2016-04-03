Admin4rails.setup do
  resource class: Post do
    icon 'fa-table'
  end

  resource class: Comment

  # grid do
  #   scope lambda {}
  #   columns lambda {}
  #   filters lambda {}
  # end

  controller do
    index do
      # override lambda { |sender|
      #  @grid = Admin4rails::Grid::Controller.grid(resource, params)
      # }
    end
  end

  # controller do
  #   index do
  #     format_html lambda {}
  #     format_json lambda {}
  #
  #     render_html lambda {}
  #     render_json lambda {}
  #
  #     override
  #   end
  #
  #   permitted_params lambda {}
  #   find_record lambda {}
  # end
end
