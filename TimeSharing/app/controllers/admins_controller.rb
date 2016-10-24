class AdminsController < ApplicationController
	def admin
	end

	def mod
	end

	def transazioni
		@transazioni=Transazione.all
	end
	
	def transazioniadmin
		@transazioni=Transazione.all
	end
end
