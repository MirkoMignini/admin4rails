module PostsController
end

module PostsGridController
  def grid_filters
    filter(:title)
    filter(:description)
  end

  def grid_columns
    super
    column('', html: true) do |record|
      link_to('Comments', @parent_records + [record, :comments])
    end
  end
end
