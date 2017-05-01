require 'rails_helper'

RSpec.describe "Admin modify user permission", :type => :feature do
	before(:each) do
		@user=create(:admin)
		@user2=create(:user2)
		visit "/"
		click_link "Login"
		within('form') do
			fill_in "email", with: @user.email
			fill_in "password", with: "password"
		end
		click_button "Log in"
		click_link "Gestione"
	end

	it "modifies the user permission" do
		within("form#permission") do
			fill_in "nick", with: @user2.nickname
			fill_in "permission", with: 2
		end
		click_button "Grant"
		visit "/users/2"
		expect(page).to have_text("Access: 2")
	end
end