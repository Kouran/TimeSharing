class RemoveUserIdFromPersonalData < ActiveRecord::Migration
  def change
	remove_column :personal_data, :user_id
	remove_column :user_platform_data, :user_id
	remove_column :transactions, :ad_id
  end
end
