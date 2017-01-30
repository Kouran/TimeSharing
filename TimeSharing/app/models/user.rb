class User < ActiveRecord::Base
	has_one :plat, class_name: UserPlatformDatum
	validates_presence_of :nickname, :email, :password, :password_confirmation, :plat
	validates_uniqueness_of :email, :nickname
	before_save {self.email=email.downcase}
	has_secure_password
end
