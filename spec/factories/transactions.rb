FactoryBot.define do
  factory :transaction do
    description { "MyString" }
    category { "MyString" }
    value { "" }
    type { 1 }
    account { nil }
  end
end
