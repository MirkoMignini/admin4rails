FactoryGirl.define do
  factory :admin_user do
    email "admin#{Random.new.rand(0..100)}@admin.com"
    password 'password123!'
    password_confirmation 'password123!'
  end
end
