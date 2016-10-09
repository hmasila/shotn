FactoryGirl.define do
  factory :link do
    full_url 'https://www.google.com'
    vanity_string Faker::Internet.password(2, 6)
    clicks 1
    deleted false
    active true
  end
end
