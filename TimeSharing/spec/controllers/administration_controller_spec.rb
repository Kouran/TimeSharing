require 'rails_helper'

RSpec.describe AdministrationController, :type=> :controller do
	describe "GET admin" do
		context "when user is logged and is administrator" do
			it "renders the administration page" do
				user=build(:admin)
				user.save
				controller.session[:user_id]=user.id
				get :admin
				expect(response).to render_template("admin")
			end
		end
		context "when user is not administrator or not logged" do
			it "redirects to unauthorized page" do
				get :admin
				expect(response).to redirect_to("/unauthorized")
			end
		end
	end
	
	describe "GET mod" do
		context "when user is logged and is moderator" do
			it "renders the moderation page" do
				user=build(:mod)
				user.save
				controller.session[:user_id]=user.id
				get :mod
				expect(response).to render_template("mod")
			end
		end
		context "when user is not moderator or not logged" do
			it "redirects to unauthorized page" do
				get :mod
				expect(response).to redirect_to("/unauthorized")
			end
		end
	end

	describe "GET unauthorized" do
		it "renders the unauthorized page" do
				get :unauthorized
				expect(response).to render_template("unauthorized")
			end
		
	end
end
