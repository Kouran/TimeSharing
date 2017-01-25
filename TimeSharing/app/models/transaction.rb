class Transaction < ActiveRecord::Base
	validates_presence_of :from, :to, :amount, :ad_id
end
