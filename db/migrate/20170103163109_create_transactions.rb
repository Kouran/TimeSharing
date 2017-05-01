class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.string :ad_id
      t.string :from
      t.string :to
      t.integer :amount

      t.timestamps
    end
  end
end
