Admin4rails.setup do
  resource class: Post do
    icon 'fa-table'
  end

  resource class: Comment do
    belongs_to :post
  end

  resource class: Reply do
    belongs_to :comment
  end

  resource class: AdminUser do
    icon 'fa-user-md'
  end
end
