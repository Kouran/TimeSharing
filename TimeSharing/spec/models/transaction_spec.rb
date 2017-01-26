require 'rails_helper'

RSpec.describe Transaction, :type=> :model do
	it "is valid with valid attributes" do
		transaction=Transaction.new(:from_id => 1, :to_id => 2, :amount => 11, :ad_id => 1)
		expect(transaction).to be_valid
		end
	it "is not valid without a sender" do
		transaction=Transaction.new(:to_id => 1, :amount => 11, :ad_id => 1)
		expect(transaction).to_not be_valid
		end
	it "is not valid without a receiver" do
		transaction=Transaction.new(:from_id => 1, :amount => 11, :ad_id => 1)
		expect(transaction).to_not be_valid
		end
	it "is not valid without an amount" do
		transaction=Transaction.new(:from_id => 1, :to_id => 2, :ad_id => 1)
		expect(transaction).to_not be_valid
		end
	it "is not valid without a related ad" do
		transaction=Transaction.new(:from_id => 1, :to_id => 2, :amount => 11)
		expect(transaction).to_not be_valid
		end
	it "is not valid with a non-positive amount" do
		transaction=Transaction.new(:from_id => 1, :to_id => 2, :amount => -1, :ad_id => 1)
		expect(transaction).to_not be_valid
		end
end
