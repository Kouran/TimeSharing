require 'rails_helper'

RSpec.describe "Closing an existing ad", :type => :feature do
	before(:each) do
		@user=create(:user)
		@user2=create(:user2)
		@ad=create(:ad)
		@ad.applicant_user=@user.nickname
		@ad.save
		visit "/"
		click_link "Login"
		within('form') do
			fill_in "email", with: @user.email
			fill_in "password", with: "password"
		end
		click_button "Log in"
		visit "/ads/1"
	end

	it "closes the ad" do
		click_link "Close this ad"
		within('form') do
			fill_in "to", with: @user2.nickname
			fill_in "amount", with: "2"
		end
		click_button "Submit"
		visit "/ads/1"
		expect(page).to have_text("Closed: true")
	end

end
