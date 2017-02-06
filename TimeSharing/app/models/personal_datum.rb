class PersonalDatum < ActiveRecord::Base
	belongs_to :user, class_name: User
	validates_presence_of :user
	validates_uniqueness_of :user
end
