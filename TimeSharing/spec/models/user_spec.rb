require 'rails_helper'

RSpec.describe User, :type=> :model do
	context "when created" do
		it "is valid with valid attributes" do
			plat=UserPlatformDatum.new
			user=User.new(:email => "email@email.com", :password => "password", :password_confirmation => "password", :nickname => "nickname")
			user.plat=plat
			expect(user).to be_valid
		end
		it "is not valid without an email" do
			user=User.create(:password => "password", :password_confirmation => "password", :nickname => "nickname")
			expect(user).to_not be_valid
		end
		it "is not valid without a nickname" do
			user=User.create(:email => "email@email.com", :password => "password", :password_confirmation => "password")
			expect(user).to_not be_valid
		end
		it "is not valid without a password" do
			user=User.create(:email => "email@email.com", :nickname => "nickname")
			expect(user).to_not be_valid
		end
		it "is not valid without matching password and password confirmation" do
			user=User.create(:email => "email@email.com", :password => "password", :password_confirmation => "else", :nickname => "nickname")
			expect(user).to_not be_valid
		end
		it "is not valid without platform data" do
			user=User.create(:email => "email@email.com", :password => "password", :password_confirmation => "password", :nickname => "nickname")
			user.plat=nil
			expect(user).to_not be_valid
		end
		it "has an unique email" do
			user=User.create(:email => "email@email.com", :password => "password", :password_confirmation => "password", :nickname => "nickname")
			user2=User.create(:email => "email@email.com", :password => "password", :password_confirmation => "password", :nickname => "else")
			expect(user2).to_not be_valid
		end
		it "has an unique nickname" do
			user=User.create(:email => "email@email.com", :password => "password", :password_confirmation => "password", :nickname => "nickname")
			user2=User.create(:email => "else@email.com", :password => "password", :password_confirmation => "password", :nickname => "nickname")
			expect(user2).to_not be_valid
		end
	end
end
