class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
	:acts_as_messageable
	def mailboxer_name
	self.name		
	end	
	def mail_email(object)
	self.mail
	end

end
