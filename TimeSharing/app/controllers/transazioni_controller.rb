class TransazioniController < ApplicationController

	def crea
		@transazione=Transazione.new(params(:transazione))
		
		@transazione.save
		redirect_to "/annunci/annuncio/#{transazione.id}"
	end
	
	def annulla
		@transazione=Transazione.find(:id)
		
		#Ritrova gli utenti
		@offerente=Utente.find_by(nome: @transazione.offerente)
		@lavoratore=Utente.find_by(nome: @transazione.lavoratore)

		#Ripristina lo stato precedente
		@offerente.ore+=@transazione.transazione
		@lavoratore.ore-=@transazione.transazione
		@offerente.save
		@lavoratore.save

		#Riapre l'annuncio
		@annuncio=Annuncio.find(@transazione.annuncio)
		@annuncio.risolto=0
		@annuncio.save

		#Elimina la transazione
		@transazione.delete
		redirect_to "/admins/annunciadmin"
	end
end
