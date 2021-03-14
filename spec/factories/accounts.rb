FactoryBot.define do
  factory :account do
    name { FFaker::Name.name }
    initial_value { FFaker.rand(0..2000) }
    user { create(:user) }
    active { true }
  end
end
