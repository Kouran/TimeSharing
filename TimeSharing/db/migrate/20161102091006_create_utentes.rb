class CreateUtentes < ActiveRecord::Migration
  def change
    create_table :utentes do |t|
      t.string :nome
      t.string :cognome
      t.string :nickname
      t.date :data_nascita
      t.string :citta_residenza
      t.string :professione
      t.string :email
      t.integer :telefono
      t.text :competenze
      t.float :portafoglio

      t.timestamps
    end
  end
end
