class CreateAds < ActiveRecord::Migration
  def change
    create_table :ads do |t|
      t.string :title
      t.string :category
      t.text :description
      t.text :zone
      t.float :expected_hours
      t.date :deadline
      t.boolean :request
      t.boolean :closed
      t.string :applicant_user
      t.string :fullfiller_user

      t.timestamps
    end
  end
end
