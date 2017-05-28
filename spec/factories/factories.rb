FactoryGirl.define do
  factory :comment do
    body Faker::Lorem.paragraph(2)
    product
  end
  
  factory :product do
    name { Faker::Name.title }
    brand Faker::Company.name
  end

  factory :user do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    email { Faker::Internet.email }
    password "secret"
    password_confirmation "secret"
    admin false

    factory :admin do
      admin true
    end
  end

  factory :usage_manifest do
    user
    product
    status :using
    approved_image
  end

  factory :approval_image, aliases: [:approved_image] do
    user
    product
    status :waiting_approval
    image Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec', 'support', 'images', 'products', 'product1.jpg'))
  end

  factory :product_usage do
    user
    product_name Faker::Name.title
    usage_status :using
    images do 
      [Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec', 'support', 'images', 'products', 'product1.jpg')),
      Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec', 'support', 'images', 'products', 'product1.jpg'))]
    end
    comment_body Faker::Lorem.paragraph
  end
end