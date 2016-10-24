class CreateTransaziones < ActiveRecord::Migration
  def change
    create_table :transaziones do |t|
      t.integer :annuncio
      t.string :offerente
      t.string :lavoratore
      t.integer :transazione

      t.timestamps
    end
  end
end
