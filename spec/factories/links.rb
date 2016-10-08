FactoryGirl.define do
  factory :link do
    full_url Faker::Internet.url
    vanity_string Faker::Internet.slug
    clicks 1
    deleted false
    active true
  end
end
