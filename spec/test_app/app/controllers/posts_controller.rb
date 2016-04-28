module PostsController
end

module PostsGridController
  def grid_columns
    super
    column('', html: true) do |record|
      link_to('Comments', post_comments_path(record))
    end
  end
end
