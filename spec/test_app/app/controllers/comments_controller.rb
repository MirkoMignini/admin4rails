module CommentsController
end

module CommentsGridController
  def grid_columns
    super
    column('', html: true) do |record|
      link_to('Replies', post_comment_replies_path(record.post_id, record))
    end
  end
end
