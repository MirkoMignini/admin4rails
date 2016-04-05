AdminUser.create!(email: 'admin@admin4rails.com', password: 'password', password_confirmation: 'password')

1000.times do |i|
  Post.create(title: "Test #{i}", description: 'Long long long description')
end
