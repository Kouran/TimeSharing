class UserPlatformDatum < ActiveRecord::Base
	belongs_to :user, class_name: User
	validates_presence_of :wallet, :access
	validates_inclusion_of :access, :in => 0..3
end
