require 'rails_helper'

RSpec.describe Message, :type=> :model do
	context "when created" do
		it "is valid with valid attributes" do
			message=Message.new(:sender => "Sender", :receiver => "Receiver", :title => "Title", :body => "Body")
			expect(message).to be_valid
		end
		it "is not valid without a sender" do
			message=Message.new(:receiver => "Receiver", :title => "Title", :body => "Body")
			expect(message).to_not be_valid
		end
		it "is not valid without a receiver" do
			message=Message.new(:sender => "Sender", :title => "Title", :body => "Body")
			expect(message).to_not be_valid
		end
		it "is not valid without a title" do
			message=Message.new(:sender => "Sender", :receiver => "Receiver", :body => "Body")
			expect(message).to_not be_valid
		end
		it "is not valid without a body" do
			message=Message.new(:sender => "Sender", :receiver => "Receiver", :title => "Title")
			expect(message).to_not be_valid
		end
	end
end
