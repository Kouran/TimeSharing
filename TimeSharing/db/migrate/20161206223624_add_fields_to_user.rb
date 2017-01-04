class AddFieldsToUser < ActiveRecord::Migration
  def change
    add_column :users, :name, :string
    add_column :users, :surname, :string
    add_column :users, :nickname, :string
    add_column :users, :password, :string
    add_column :users, :birthdate, :date
    add_column :users, :place, :text
    add_column :users, :profession, :string
    add_column :users, :mail, :string
    add_column :users, :skills, :text
  end
end
