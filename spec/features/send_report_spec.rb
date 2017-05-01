require 'rails_helper'

RSpec.describe "Send a report", :type => :feature do
	before(:each) do
		@user=create(:user)
		visit "/"
		click_link "Login"
		within('form') do
			fill_in "email", with: @user.email
			fill_in "password", with: "password"
		end
		click_button "Log in"
		click_link "Report"
	end

	it "sends a report to admin or mod" do
		within('form') do
			choose "Admin"
			fill_in "title", with: "Report"
			fill_in "body", with: "Something important"
		end
		click_button "Send"
		expect(current_path).to eq("/messages/1")
	end
end
