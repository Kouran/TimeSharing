require 'rails_helper'

RSpec.describe Message, :type=> :model do
	context "when created" do
		it "is valid with valid attributes" do
			message=build(:message)
			expect(message).to be_valid
		end
		it "is not valid without a sender" do
			message=build(:message)
			message.sender=nil
			expect(message).to_not be_valid
		end
		it "is not valid without a receiver" do
			message=build(:message)
			message.receiver=nil
			expect(message).to_not be_valid
		end
		it "is not valid without a title" do
			message=build(:message)
			message.title=nil
			expect(message).to_not be_valid
		end
		it "is not valid without a body" do
			message=build(:message)
			message.body=nil
			expect(message).to_not be_valid
		end
	end
end
