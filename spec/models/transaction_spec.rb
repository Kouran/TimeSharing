require 'rails_helper'

RSpec.describe Transaction, :type=> :model do
	context "when created" do
		it "is valid with valid attributes" do
			transaction=build(:transaction)
			expect(transaction).to be_valid
		end
		it "is not valid without a sender" do
			transaction=build(:transaction)
			transaction.from=nil
			expect(transaction).to_not be_valid
		end
		it "is not valid without a receiver" do
			transaction=build(:transaction)
			transaction.to=nil
			expect(transaction).to_not be_valid
		end
		it "is not valid without an ad" do
			transaction=build(:transaction)
			transaction.ad=nil
			expect(transaction).to_not be_valid
		end
		it "is not valid with a non-positive amount" do
			transaction=build(:transaction)
			transaction.amount=-1
			expect(transaction).to_not be_valid
		end
		it "is not valid without an amount" do
			transaction=build(:transaction)
			transaction.amount=nil
			expect(transaction).to_not be_valid
		end
	end
end
