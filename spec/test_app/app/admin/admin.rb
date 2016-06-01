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
    member_action verb: :put, method: 'test_action'
  end

  resource class: Physician do
  end

  resource class: Patient do
  end
end
