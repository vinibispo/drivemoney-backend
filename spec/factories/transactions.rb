FactoryBot.define do
  factory :transaction do
    description { FFaker::Product.product }
    category { FFaker::Product.brand }
    value { FFaker::Random.rand(100..999) }
    account { create(:account) }
  end
end
