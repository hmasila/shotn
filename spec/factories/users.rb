FactoryGirl.define do
  factory :user do
    name Faker::Name.name
    password Faker::Internet.password(8)
    email Faker::Internet.email
  end
end
