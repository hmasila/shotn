FactoryGirl.define do
  factory :link do
    full_url "MyString"
    vanity_string "MyString"
    clicks 1
    deleted false
    active false
  end
end
