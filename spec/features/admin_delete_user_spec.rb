require 'rails_helper'

RSpec.describe "Admin deletes an user", :type => :feature do
	before(:each) do
		@user=create(:admin)
		@user2=create(:user2)
		@user2.nickname="This"
		@user2.save
		visit "/"
		click_link "Login"
		within('form') do
			fill_in "email", with: @user.email
			fill_in "password", with: "password"
		end
		click_button "Log in"
		click_link "Gestione"
	end

	it "deletes an user" do
		within('form#user') do
			fill_in "nick", with: @user2.nickname
		end
		click_button "Delete User"
		visit "/users"
		expect(page).to_not have_text("This")
	end
end
