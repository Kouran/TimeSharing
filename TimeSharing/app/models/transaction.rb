class Transaction < ActiveRecord::Base
	belongs_to :from, class_name: User
	belongs_to :to, class_name: User
	belongs_to :ad, class_name: Ad
	validates_presence_of :from_id
	validates_presence_of :to_id
	validates_presence_of :ad_id
	validates_presence_of :amount
	validates :amount, numericality: {greater_than: 0}
end
