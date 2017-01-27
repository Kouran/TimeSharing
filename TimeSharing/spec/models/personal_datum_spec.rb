require 'rails_helper'

RSpec.describe PersonalDatum, :type=> :model do
	context "when created" do
		it "is valid with valid attributes" do
			user=User.new
			personal=PersonalDatum.new(:name => "Name", :surname => "Surname", :date_of_birth => Date.current, :city => "Megaton", :actual_job => "Tester", :phone => "NaN", :skills => "Some")
			personal.user=user
			expect(personal).to be_valid
		end
		it "is valid with only user defined" do
			user=User.new
			personal=PersonalDatum.new
			personal.user=user
			expect(personal).to be_valid
		end
		it "is not valid without an user" do
			personal=PersonalDatum.new(:name => "Name", :surname => "Surname", :date_of_birth => Date.current, :city => "Megaton", :actual_job => "Tester", :phone => "NaN", :skills => "Some")
			expect(personal).to_not be_valid
		end
	end
end
