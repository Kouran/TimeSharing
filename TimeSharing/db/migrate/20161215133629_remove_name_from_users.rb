class RemoveNameFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :name, :string
    remove_column :users, :password, :string
    remove_column :users, :birthdate, :date
    remove_column :users, :place, :text
    remove_column :users, :profession, :string
    remove_column :users, :mail, :string
    remove_column :users, :skills, :text
  end
end
