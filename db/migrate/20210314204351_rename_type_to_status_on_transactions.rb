class RenameTypeToStatusOnTransactions < ActiveRecord::Migration[6.0]
  def change
    change_table :transactions do |t|
      t.rename :type, :status
    end
  end
end
