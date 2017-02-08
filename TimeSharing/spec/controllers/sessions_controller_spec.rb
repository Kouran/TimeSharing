require 'rails_helper'

RSpec.describe SessionsController, :type=> :controller do
	describe "GET new" do
		it "renders the new page" do
			get :new
			expect(response).to render_template('new')
		end
	end

	describe "POST create" do
		context "when parameters are valid" do
			before(:each) do
				@user=create(:user)
				post :create, session: {email: @user.email, password: "password"}
			end
			it "logs the user" do
				expect(controller.session[:user_id]).to eq(@user.id)
			end
			it "redirects to home" do
				expect(response).to redirect_to("/")
			end
		end
		context "when parameters are invalid" do
			before(:each) do
				@user=create(:user)
				post :create, session: {email: @user.email, password: "wrong"}
			end
			it "doesn't log the user" do
				expect(controller.session[:user_id]).to_not eq(@user.id)
			end
			it "redirects to back" do
				expect(response).to render_template("new")
			end
		end
	end

	describe "DELETE destroy" do
		before(:each) do
			@user=create(:user)
			controller.session[:user_id]=@user.id
			delete :destroy
		end
		it "logs out the user" do
			expect(controller.session[:user_id]).to_not eq(@user.id)
		end
		it "redirects to home" do
			expect(response).to redirect_to("/")
		end
	end
end
