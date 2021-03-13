require "securerandom"
FactoryBot.define do
  factory :user_token do
    token { SecureRandom.uuid }
    user { create(:user) }
  end
end
