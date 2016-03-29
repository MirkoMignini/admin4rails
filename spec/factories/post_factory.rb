FactoryGirl.define do
  factory :post do
    sequence(:title) { |n| "Title #{n}" }
    description 'Description'
  end

  factory :post_invalid, class: Post do
    title ''
    description 'Description'
  end
end
