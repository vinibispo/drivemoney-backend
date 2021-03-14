FactoryBot.define do
  factory :account do
    name { "MyString" }
    initial_value { "" }
    user { nil }
    active { false }
  end
end
