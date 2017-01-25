require 'rails_helper'

RSpec.describe Transaction, :type=> :model do
	it "is valid with valid attributes" do
		transaction=Transaction.new
		transaction.from="a"
		transaction.to="b"
		transaction.amount=11
		transaction.ad_id=1
		expect(transaction).to be_valid
		end
	it "is not valid without a sender" do
		transaction=Transaction.new
		transaction.to="b"
		transaction.amount=11
		transaction.ad_id=1
		expect(transaction).to_not be_valid
		end
	it "is not valid without a receiver" do
		transaction=Transaction.new
		transaction.from="a"
		transaction.amount=11
		transaction.ad_id=1
		expect(transaction).to_not be_valid
		end
	it "is not valid without an amount" do
		transaction=Transaction.new
		transaction.from="a"
		transaction.to="b"
		transaction.ad_id=1
		expect(transaction).to_not be_valid
		end
	it "is not valid without a related ad" do
		transaction=Transaction.new
		transaction.from="a"
		transaction.to="b"
		transaction.amount=11
		expect(transaction).to_not be_valid
		end
end
