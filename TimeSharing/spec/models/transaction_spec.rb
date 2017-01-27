require 'rails_helper'

RSpec.describe Transaction, :type=> :model do
	context "when created" do
		it "is valid with valid attributes" do
			transaction=Transaction.new(:amount => 11)
			sender=User.new
			transaction.from=sender
			receiver=User.new
			transaction.to=receiver
			ad=Ad.new
			transaction.ad=ad
			expect(transaction).to be_valid
		end
		it "is not valid without a sender" do
			transaction=Transaction.new(:amount => 11)
			receiver=User.new
			transaction.to=receiver
			ad=Ad.new
			transaction.ad=ad
			expect(transaction).to_not be_valid
		end
		it "is not valid without a receiver" do
			transaction=Transaction.new(:amount => 11)
			sender=User.new
			transaction.from=sender
			ad=Ad.new
			transaction.ad=ad
			expect(transaction).to_not be_valid
		end
		it "is not valid without an ad" do
			transaction=Transaction.new(:amount => 11)
			sender=User.new
			transaction.from=sender
			receiver=User.new
			transaction.to=receiver
			expect(transaction).to_not be_valid
		end
		it "is not valid with a non-positive amount" do
			transaction=Transaction.new(:amount => -11)
			sender=User.new
			transaction.from=sender
			receiver=User.new
			transaction.to=receiver
			ad=Ad.new
			transaction.ad=ad
			expect(transaction).to_not be_valid
		end
		it "is not valid without an amount" do
			transaction=Transaction.new
			sender=User.new
			transaction.from=sender
			receiver=User.new
			transaction.to=receiver
			ad=Ad.new
			transaction.ad=ad
			expect(transaction).to_not be_valid
		end
	end
end
