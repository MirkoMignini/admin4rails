1000.times do |i|
  Post.create(title: "Test #{i}", description: 'Long long long description')
end
