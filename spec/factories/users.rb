FactoryBot.define do
  factory :user do
    first_name { "MyString" }
    last_name { "MyString" }
    email { FFaker::Internet.email }
    password { FFaker::Internet.password }
  end
end
