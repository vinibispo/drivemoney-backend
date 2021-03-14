class CreateTransactions < ActiveRecord::Migration[6.0]
  def change
    create_table :transactions do |t|
      t.string :description
      t.string :category
      t.money :value
      t.integer :type
      t.references :account, null: false, foreign_key: true

      t.timestamps
    end
  end
end
