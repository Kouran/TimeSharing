require 'rails_helper'

RSpec.describe "The sign up process", :type => :feature do
	before(:each) do
		@user=create(:user)
		visit "/"
		click_link "Login"
	end
	it "redirects to home page if parameters are right" do
		within('form') do
			fill_in "email", with: @user.email
			fill_in "password", with: "password"
		end
		click_button "Log in"
		expect(current_path).to eq("/")
	end
	it "remains in login page if parameters aren't right" do
		within('form') do
			fill_in "email", with: @user.email
			fill_in "password", with: "wrong"
		end
		click_button "Log in"
		expect(current_path).to eq("/login")
	end

end
