require 'rails_helper'

RSpec.describe "Sending a new message", :type => :feature do
	before(:each) do
		@user=create(:user)
		visit "/"
		click_link "Login"
		within('form') do
			fill_in "email", with: @user.email
			fill_in "password", with: "password"
		end
		click_button "Log in"
		click_link "Nuovo messaggio"
	end

	it "redirects to the message if parameters are right" do
		within('form') do
			fill_in "receiver", with: "someone"
			fill_in "title", with: "title"
			fill_in "body", with: "hi"
		end
		click_button "send"
		expect(current_path).to eq("/messages/1")
	end
	it "renders the creation page if parameters aren't right" do
		within('form') do
			fill_in "receiver", with: "someone"
			fill_in "body", with: "hi"
		end
		click_button "send"
		expect(page).to have_text('New message')
	end
end
