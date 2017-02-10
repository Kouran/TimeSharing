require 'rails_helper'

RSpec.describe "Admin views reports", :type => :feature do
	before(:each) do
		@user=create(:admin)
		@message=create(:message)
		@message.receiver="admin"
		@message.body="This"
		@message.save
		visit "/"
		click_link "Login"
		within('form') do
			fill_in "email", with: @user.email
			fill_in "password", with: "password"
		end
		click_button "Log in"
		click_link "Gestione"
	end

	it "views the reports" do
		click_link "See received reports"
		expect(page).to have_text("This")
	end
end