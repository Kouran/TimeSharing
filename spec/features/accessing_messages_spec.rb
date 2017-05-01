require 'rails_helper'

RSpec.describe "Accessing user's own messages", :type => :feature do
	before(:each) do
		@user=create(:user)
		@owned=create(:message)
		@owned.sender=@user.nickname
		@owned.body="This is an owned message"
		@owned.save
		@not=create(:message)
		@not.body="Not owned by user"
		@not.save
		visit "/"
		click_link "Login"
		within('form') do
			fill_in "email", with: @user.email
			fill_in "password", with: "password"
		end
		click_button "Log in"
		click_link "I tuoi messaggi"
	end

	it "shows user's messages" do
		expect(page).to have_text("This is an owned message")
	end
	it "doesn't show messages not owned by user" do
		expect(page).to_not have_text("Not owned by user")
	end

end
