json.array!(@annuncios) do |annuncio|
  json.extract! annuncio, :id, :titolo, :categoria, :descrizione, :zona, :ore_previste, :scadenza, :data, :foto, :richiesta, :risolta, :utente_richiedente, :utente_adempiente
  json.url annuncio_url(annuncio, format: :json)
end
