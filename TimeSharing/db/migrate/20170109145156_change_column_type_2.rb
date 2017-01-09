class ChangeColumnType2 < ActiveRecord::Migration
  def change
	change_column :transactions, :ad_id, :integer
  end
end
