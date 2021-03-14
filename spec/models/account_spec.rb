require "rails_helper"

RSpec.describe Account, type: :model do
  it { should validate_presence_of(:name) }
  it "expects total be sum_of_transactions" do
    account = create(:account)
    transactions = create_list(:transaction, FFaker::Random.rand(1..10), account: account)
    sum_of_transactions = transactions.inject(account.initial_value) do |sum, transaction|
      sum + transaction.value
    end
    expect(account.total).to eq(sum_of_transactions)
  end
end
