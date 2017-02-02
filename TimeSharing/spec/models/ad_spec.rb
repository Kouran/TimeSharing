require 'rails_helper'

RSpec.describe Ad, :type=> :model do
	context "when created" do
		it "is valid with valid attributes" do
			ad=build(:ad)
			expect(ad).to be_valid
		end
		it "is not valid without a title" do
			ad=build(:ad)
			ad.title=nil
			expect(ad).to_not be_valid
		end
		it "is not valid without a category" do
			ad=build(:ad)
			ad.category=nil
			expect(ad).to_not be_valid
		end
		it "is not valid without a description" do
			ad=build(:ad)
			ad.description=nil
			expect(ad).to_not be_valid
		end
		it "is not valid without expected hours" do
			ad=build(:ad)
			ad.expected_hours=nil
			expect(ad).to_not be_valid
		end
		it "is not valid without a deadline" do
			ad=build(:ad)
			ad.deadline=nil
			expect(ad).to_not be_valid
		end
		it "is not valid without an applicant" do
			ad=build(:ad)
			ad.applicant_user=nil
			expect(ad).to_not be_valid
		end
		it "is not valid without a positive amount of expected hours" do
			ad=build(:ad)
			ad.expected_hours=-1
			expect(ad).to_not be_valid
		end
	end
end
