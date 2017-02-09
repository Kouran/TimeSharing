require 'rails_helper'

RSpec.describe "Adding a new ad", :type => :feature do
	before(:each) do
		@user=create(:user)
		visit "/"
		click_link "Login"
		within('form') do
			fill_in "email", with: @user.email
			fill_in "password", with: "password"
		end
		click_button "Log in"
		click_link "Nuovo annuncio"
	end
	it "redirects to the ad if parameters are right" do
		within('form') do
			fill_in "title", with: "title"
			fill_in "category", with: "category"
			fill_in "description", with: "description"
			fill_in "expected_hours", with: "2"
			#select "2017/02/20", from: "deadline"
		end
		click_button "Submit"
		expect(current_path).to eq("/ads/1")
	end
	it "remains on creation page if parameters aren't right" do
		within('form') do
			fill_in "category", with: "category"
			fill_in "description", with: "description"
			fill_in "expected_hours", with: "2"
			#select "2017/02/20", from: "deadline"
		end
		click_button "Submit"
		expect(current_path).to eq("/Ads/New")
	end
end
