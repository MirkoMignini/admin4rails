module PostsController
end

module PostsGridController
  def grid_columns
    super
    column('', html: true) do |record|
      link_to('Comments', @parent_records + [record, :comments])
    end
  end
end
