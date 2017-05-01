class ChangeColumnType < ActiveRecord::Migration
  def change
	change_column :personal_data, :user_id, :integer
	change_column :user_platform_data, :user_id, :integer
  end
end
