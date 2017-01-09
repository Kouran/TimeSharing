class AddUserIdToPersonalData < ActiveRecord::Migration
  def change
	add_column :personal_data, :user_id, :integer
	add_column :user_platform_data, :user_id, :integer
	add_column :transactions, :ad_id, :integer
  end
end
