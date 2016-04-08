Admin4rails.setup do
  resource class: Post do
    icon 'fa-table'
  end

  resource class: Comment

  resource class: AdminUser do
    icon 'fa-user-md'
    index do
      fields [:name, :surname, :email, :last_sign_in_at, :sign_in_count]
    end
    show do
      fields %w(name surname email sign_in_count current_sign_in_at
                last_sign_in_at last_sign_in_ip created_at)
    end
    new_form do
      custom 'admin_user/new_fields'
      permitted_params [:name, :surname, :email, :password, :password_confirmation]
    end
    edit_form do
      fields [:name, :surname, :email]
    end
  end
end
