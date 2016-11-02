json.array!(@utentes) do |utente|
  json.extract! utente, :id, :nome, :cognome, :nickname, :data_nascita, :citta_residenza, :professione, :email, :telefono, :competenze, :portafoglio
  json.url utente_url(utente, format: :json)
end
