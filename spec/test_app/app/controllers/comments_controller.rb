module CommentsController
end

module CommentsGridController
  def grid_columns
    super
    column('', html: true) do |record|
      link_to('Replies', @parent_records + [record, :replies])
    end
  end
end
