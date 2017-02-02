require 'rails_helper'

RSpec.describe UserPlatformDatum, :type=> :model do
	context "when created" do
		it "is valid with valid attributes" do
			user=build(:user)
			plat=build(:user_data)
			plat.user=user
			expect(plat).to be_valid
		end
		it "is not valid without an access level" do
			user=build(:user)
			plat=build(:user_data)
			plat.access=nil
			plat.user=user
			expect(plat).to_not be_valid
		end
		it "is not valid without a wallet" do
			user=build(:user)
			plat=build(:user_data)
			plat.user=user
			plat.wallet=nil
			expect(plat).to_not be_valid
		end
		it "is not valid with an access level not in 0-3" do
			user=build(:user)
			plat=build(:user_data)
			plat.user=user
			plat.access=11
			expect(plat).to_not be_valid
		end
	end
end
