class Transaction < ActiveRecord::Base
	belongs_to :from, class_name: User
	belongs_to :to, class_name: User
	belongs_to :ad, class_name: Ad
	validates_presence_of :amount, :from, :to, :ad
	validates :amount, numericality: {greater_than: 0}
end
