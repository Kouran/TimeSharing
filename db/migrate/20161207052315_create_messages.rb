class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.string :sender
      t.string :receiver
      t.string :title
      t.text :body

      t.timestamps
    end
  end
end
