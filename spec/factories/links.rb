FactoryGirl.define do
  factory :link do
    full_url 'https://www.google.com'
    vanity_string Faker::Internet.slug
    clicks 1
    deleted false
    active true
  end
end
