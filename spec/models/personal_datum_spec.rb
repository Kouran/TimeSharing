require 'rails_helper'

RSpec.describe PersonalDatum, :type=> :model do
	context "when created" do
		it "is valid with valid attributes" do
			personal=build(:personaldatum)
			expect(personal).to be_valid
		end
		it "is not valid without an user" do
			personal=build(:personaldatum)
			personal.user=nil
			expect(personal).to_not be_valid
		end
		it "is not valid if duplicated user" do
			personal2=build(:personaldatum)			
			personal=build(:personaldatum)
			user=create(:user)
			personal2.user=user
			personal2.save
			personal.user=user
			expect(personal).to_not be_valid
		end
	end
end
