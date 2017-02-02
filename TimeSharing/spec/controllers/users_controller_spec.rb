require 'rails_helper'

RSpec.describe UsersController, :type=> :controller do
	describe "GET index" do
		context "when user is admin" do
			before(:each) do
				user=create(:admin)
				controller.session[:user_id]=user.id
			end
			it "assigns @users" do
				get :index
				expect(assigns(:users)).to eq(User.all)
				end
			it "renders 'index'" do
				get :index
				expect(response).to render_template("index")
				end
		end
		context "when user is not admin or not logged" do
			it "redirects to a specific unauthorized page" do
				get :index
				expect(response).to redirect_to("/unauthorized")
			end
		end
	end

	describe "GET new" do
		it "renders the 'new' view" do
			get :new
			expect(response).to render_template("new")
		end
	end

	describe "GET edit" do
		context "when user is logged and tries to access its data" do
			it "renders the 'edit' view" do
				user=create(:user)
				controller.session[:user_id]=user.id
				get :edit, id: user.id
				expect(response).to render_template("edit")
			end
		end
		context "when user is admin and tries to access someone else's data" do
			it "renders the 'edit' view" do
				user=create(:admin)
				user2=create(:user2)
				controller.session[:user_id]=user.id
				get :edit, id: user2.id
				expect(response).to render_template("edit")
			end
		end
		context "when user tries to access someone else's data not being admin" do
			it "redirects to a specific unauthorized page" do
				user=create(:user)
				user2=create(:user2)
				controller.session[:user_id]=user.id
				get :edit, id: user2.id
				expect(response).to redirect_to("/unauthorized")
			end
		end
		context "when user is not logged" do
			it "redirects to a specific unauthorized page" do
				user=create(:user)
				get :edit, id: user.id
				expect(response).to redirect_to("/unauthorized")
			end
		end
	end
	
	describe "POST create" do
		context "when valid parameters are passed" do
			before(:each) do
				post :create, {:user => {:nickname => "tizio", :email => "email@m.com", :password => "pass", :password_confirmation => "pass"}}
			end
			it "creates a new user" do
				expect(User.count).to eq(1)
			end
			it "logs the new user" do
				expect(controller.session[:user_id]).to_not be_nil
			end
			it "redirect to the created user" do
				expect(response).to redirect_to(assigns(:user))
			end
		end
		context "when invalid parameters are passed" do
			it "renders new" do
				post :create, {:user => {:email => "email@m.com", :password => "pass", :password_confirmation => "pass"}}
				expect(response).to render_template("new")
			end
		end
	end
	
	describe "PUT update" do
	end

	describe "DELETE destroy" do
	end

	describe "POST nick_destroy" do
	end

end
