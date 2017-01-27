class Message < ActiveRecord::Base
	validates_presence_of :sender, :receiver, :title, :body

	def self.search(search)
		where("title LIKE?", "%#{search}%")
		where("receiver LIKE?", "%#{search}%")
		#provare anche per le parole del messaggio
	end
end
