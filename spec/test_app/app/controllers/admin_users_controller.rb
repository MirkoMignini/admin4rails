module AdminUsersController
  def edit_fields
    [:name, :surname, :email]
  end

  def show_fields
    %w(name surname email sign_in_count current_sign_in_at
       last_sign_in_at last_sign_in_ip created_at)
  end

  def create_params
    [:name, :surname, :email, :password, :password_confirmation]
  end

  def test_action
    set_record
    @record.name = 'test_action'
    @record.save
    redirect_to :back
  end

  def test_action2
    set_record
    @record.name = 'test_action2'
    @record.save
    redirect_to :back
  end
end

module AdminUsersGridController
  def fields
    [:name, :surname, :email, :last_sign_in_at, :sign_in_count]
  end
end
