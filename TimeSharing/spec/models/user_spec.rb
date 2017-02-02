require 'rails_helper'

RSpec.describe User, :type=> :model do
	context "when created" do
		it "is valid with valid attributes" do
			user=build(:user)
			expect(user).to be_valid
		end
		it "is not valid without an email" do
			user=build(:user)
			user.email=nil
			expect(user).to_not be_valid
		end
		it "is not valid without a nickname" do
			user=build(:user)
			user.nickname=nil
			expect(user).to_not be_valid
		end
		it "is not valid without a password" do
			user=build(:user)
			user.password=nil
			expect(user).to_not be_valid
		end
		it "is not valid without matching password and password confirmation" do
			user=build(:user)
			user.password_confirmation="else"
			expect(user).to_not be_valid
		end
		it "is not valid without platform data" do
			user=build(:user)
			user.plat=nil
			expect(user).to_not be_valid
		end
		it "has an unique email" do
			user=create(:user)
			user2=build(:user)
			user2.nickname="else"
			expect{user2.save!}.to raise_error(ActiveRecord::RecordInvalid)
		end
		it "has an unique nickname" do
			user=create(:user)
			user2=build(:user)
			user2.email="else@mail.com"
			expect{user2.save!}.to raise_error(ActiveRecord::RecordInvalid)
		end
	end
end
