require 'rails_helper'

RSpec.describe "The sign up process", :type => :feature do
	before(:each) do
		visit "/"
		click_link "reg"
	end
	it "redirects to created user if parameters are right" do
		within('form#signup') do
			fill_in 'nickname', with: 'User'
			fill_in 'email', with: 'mail@email.com'
			fill_in 'password', with: 'pass'
			fill_in 'confirmation', with: 'pass'
		end
		click_button 'Submit'
		expect(current_path).to eq("/users/1")
	end

	it "shows an error message if parameters aren't right" do
		fill_in 'email', with: 'mail@email.com'
		fill_in 'password', with: 'pass'
		fill_in 'confirmation', with: 'pass'
		click_button 'Submit'
		expect(page).to have_content('prohibited this user from being saved')
	end

end
