require 'rails_helper'

RSpec.describe "Admin deletes transactions", :type => :feature do
	before(:each) do
		@user=create(:admin)
		@user2=create(:user)
		@user2.nickname="This"
		@user2.save
		@ad=create(:ad)
		@transaction=create(:transaction)
		@transaction.from=@user
		@transaction.to=@user2
		@transaction.ad=@ad
		@transaction.save
		visit "/"
		click_link "Login"
		within('form') do
			fill_in "email", with: @user.email
			fill_in "password", with: "password"
		end
		click_button "Log in"
		click_link "Moderazione"
	end

	it "views the reports" do
		click_link "See Transactions"
		click_link "Cancel"
		expect(page).to_not have_text("This")
	end
end