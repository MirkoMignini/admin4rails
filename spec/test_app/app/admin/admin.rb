Admin4rails.setup do
  resource class: Post do
    icon 'fa-table'
  end

  resource class: Comment
  resource class: AdminUser do
    index do
      fields [:name, :surname, :email, :last_sign_in_at, :sign_in_count]
    end
  end
end
