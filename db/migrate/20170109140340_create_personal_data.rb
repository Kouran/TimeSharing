class CreatePersonalData < ActiveRecord::Migration
  def change
    create_table :personal_data do |t|
	  t.string :user_id
      t.string :name
      t.string :surname
      t.date :date_of_birth
      t.string :city
      t.string :actual_job
      t.string :phone
      t.text :skills

      t.timestamps
    end
  end
end
