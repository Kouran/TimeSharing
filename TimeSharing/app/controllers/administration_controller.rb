class AdministrationController < ApplicationController
	def admin
		#Aggiungere controllo sui permessi utente
	end

	def mod
		#Aggiungere controllo sui permessi utente
	end

	def transactions
		#Aggiungere controllo sui permessi utente
		@transactions=Transaction.all
	end
	
	def admin_transactions
		#Aggiungere controllo sui permessi utente
		@transactions=Transaction.all
end
