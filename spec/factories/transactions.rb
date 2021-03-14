FactoryBot.define do
  factory :transaction do
    description { FFaker::Product.product }
    category { FFaker::Product.brand }
    value { FFaker::Random.rand(100..999) }
    type { 0 }
    account { create(:account) }
  end
end
