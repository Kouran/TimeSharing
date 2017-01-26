class User < ActiveRecord::Base
	has_one :plat, class_name: UserPlatformDatum
	validates_presence_of :nickname, :email
	validates_uniqueness_of :email
	before_save {self.email=email.downcase}
	has_secure_password
	

end
