class CreateUserPlatformData < ActiveRecord::Migration
  def change
    create_table :user_platform_data do |t|
      t.string :user_id
      t.integer :access
      t.integer :fullfilling_rating
      t.integer :applying_rating
      t.integer :total_rating
      t.integer :wallet

      t.timestamps
    end
  end
end
