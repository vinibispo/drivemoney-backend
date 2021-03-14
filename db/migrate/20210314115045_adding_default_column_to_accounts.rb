class AddingDefaultColumnToAccounts < ActiveRecord::Migration[6.0]
  def change
    change_column_default :accounts, :active, from: nil, to: true
    change_column_default :accounts, :initial_value, from: nil, to: 0
  end
end
