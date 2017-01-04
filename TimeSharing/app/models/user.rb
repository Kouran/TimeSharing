class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  #devise :database_authenticatable, :registerable,
  #       :recoverable, :rememberable, :trackable, :validatable
#	:acts_as_messageable
	has_many :conversations
	validates_presence_of :nickname, :email
	validates_uniqueness_of :email
	before_save {self.email=email.downcase}
	def mailboxer_name
	self.nickname		
	end	
	def mail_email(object)
	self.email
	end
	has_secure_password
	

end
