require 'rails_helper'

RSpec.describe "Mod deletes an ad", :type => :feature do
	before(:each) do
		@user=create(:mod)
		@ad=create(:ad)
		@ad.title="This"
		@ad.save
		visit "/"
		click_link "Login"
		within('form') do
			fill_in "email", with: @user.email
			fill_in "password", with: "password"
		end
		click_button "Log in"
		click_link "Moderazione"
	end

	it "deletes an ad" do
		within('form') do
			fill_in "id", with: @ad.id
		end
		click_button "Delete Ad"
		visit "/ads"
		expect(page).to_not have_text("This")
	end
end
