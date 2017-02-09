require 'rails_helper'

RSpec.describe "Register personal data", :type => :feature do
	before(:each) do
		@user=create(:user)
		visit "/"
		click_link "Login"
		within('form') do
			fill_in "email", with: @user.email
			fill_in "password", with: "password"
		end
		click_button "Log in"
		click_link "Profilo"
	end

	it "saves user data" do
		click_link "Edit your personal data"
		within('form') do
			fill_in "name", with: "my name"
		end
		click_button "Submit"
		expect(page).to have_text("my name")
	end

end
