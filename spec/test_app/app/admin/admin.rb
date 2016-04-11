Admin4rails.setup do
  resource class: Post do
    icon 'fa-table'
  end

  resource class: Comment

  resource class: AdminUser do
    icon 'fa-user-md'
  end
end
