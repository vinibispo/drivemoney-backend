FactoryBot.define do
  factory :user_token do
    token { "MyString" }
    user { nil }
  end
end
