require 'rails_helper'

RSpec.describe "Admin modify user wallet", :type => :feature do
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

	it "modifies the user wallet" do
		within("form#wallet") do
			fill_in "nick", with: @user2.nickname
			fill_in "amount", with: "2000"
		end
		click_button "Update"
		visit "/users/2"
		expect(page).to have_text("Wallet: 2002")
	end
end