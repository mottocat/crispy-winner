FactoryGirl.define do
  factory :comment do
    body Faker::Lorem.paragraph(2)
    product
  end
  
  factory :product do
    name Faker::Name.title
    brand Faker::Company.name
  end

  factory :user do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    password "secret"
    password_confirmation "secret"
  end
end