require 'rails_helper'

RSpec.describe UserPlatformDatum, :type=> :model do
	context "when created" do
		it "is valid with valid attributes" do
			user=User.new
			plat=UserPlatformDatum.new(:wallet => 0, :access => 0)
			plat.user=user
			expect(plat).to be_valid
		end
		it "is not valid without an user" do
			plat=UserPlatformDatum.new(:wallet => 0, :access => 0)
			expect(plat).to_not be_valid
		end
		it "is not valid without an access level" do
			user=User.new
			plat=UserPlatformDatum.new(:wallet => 0)
			plat.user=user
			expect(plat).to_not be_valid
		end
		it "is not valid without a wallet" do
			user=User.new
			plat=UserPlatformDatum.new(:access => 0)
			plat.user=user
			expect(plat).to_not be_valid
		end
		it "is not valid with an access level not in 0-3" do
			user=User.new
			plat=UserPlatformDatum.new(:wallet => 0, :access => 11)
			plat.user=user
			expect(plat).to_not be_valid
		end
	end
end
