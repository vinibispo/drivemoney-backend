json.extract! account ,:id, :name, :active, :initial_value, :created_at, :updated_at
json.total Balances::FetchForAccount
  .call(account: account)
  .data[:balance]
