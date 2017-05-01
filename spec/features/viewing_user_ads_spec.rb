require 'rails_helper'

RSpec.describe "Viewing own ads", :type => :feature do
	before(:each) do
		@user=create(:user)
		@own=create(:ad)
		@own.applicant_user=@user.nickname
		@own.title="This should be found"
		@not=create(:ad)
		@not.title="This shouldn't be found"
		@not.save
		@own.save
		visit "/"
		click_link "Login"
		within('form') do
			fill_in "email", with: @user.email
			fill_in "password", with: "password"
		end
		click_button "Log in"
		click_link "I tuoi annunci"
	end

	it "shows user's own ads" do
		expect(page).to have_text("This should be found")
	end
	it "doesn't show not user's ads" do
		expect(page).to_not have_text("This shouldn't be found")
	end
end
