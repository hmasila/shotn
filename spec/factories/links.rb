FactoryBot.define do
  factory :link do
    full_url { 'https://www.google.com' }
    vanity_string { Faker::Internet.username(specifier: 2..6) }
    clicks { 1 }
    deleted { false }
    active { true }
  end
end
