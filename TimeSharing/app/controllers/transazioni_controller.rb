class TransazioniController < ApplicationController

	def crea
		if request.post?
			if not Utente.exists?(nick: params(:lavoratore))
				:notice="Attenzione, utente non trovato. Controllare eventuali errori di battitura"
			elsif Utente.find_by(nick: params(:offerente)).ore<params(:transazione)
				:notice="Attenzione, l'importo in suo possesso è insufficiente a coprire la transazione"
			elsif params(:transazione)<0
				:notice="Impossibile trasferire una quantità negativa di ore"
			else				
			@transazione=Transazione.new(params(:transazione))
			@transazione.save
			@annuncio=Annuncio.find(@transazione.annuncio)
			@annuncio.risolto=1
			@annuncio.save
			redirect_to :back
		end
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
		redirect_to "/admins/transazioniadmin"
	end
end
