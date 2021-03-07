FactoryBot.define do
  factory :user do
    first_name { "MyString" }
    last_name { "MyString" }
    email { "" }
    password_digest { "MyString" }
  end
end
