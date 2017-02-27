FactoryGirl.define do
  factory :comment do
    body Faker::Lorem.paragraph(2)
    product
  end
  
  factory :product do
    name Faker::Name.title
    brand Faker::Company.name
  end
end