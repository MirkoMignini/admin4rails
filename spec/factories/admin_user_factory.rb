FactoryGirl.define do
  factory :admin_user do
    email 'admin@admin.com'
    password 'password123!'
    password_confirmation 'password123!'
  end
end
