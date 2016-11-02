class CreateAnnuncios < ActiveRecord::Migration
  def change
    create_table :annuncios do |t|
      t.string :titolo
      t.string :categoria
      t.text :descrizione
      t.text :zona
      t.float :ore_previste
      t.date :scadenza
      t.date :data
      t.string :foto
      t.boolean :richiesta
      t.boolean :risolta
      t.Utente :utente_richiedente
      t.Utente :utente_adempiente

      t.timestamps
    end
  end
end
