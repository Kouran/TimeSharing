class Message < ActiveRecord::Base
	def self.search(search)
		where("title LIKE?", "%#{search}%")
		where("receiver LIKE?", "%#{search}%")
		#provare anche per le parole del messaggio
	end
end
