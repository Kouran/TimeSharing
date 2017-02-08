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

	describe "GET show" do
		context "when parameter is valid" do
			it "renders the user" do
				user=create(:user)
				get :show, id: user.id
				expect(response).to render_template('show')
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
		context "when user is logged and tries to modify its data" do
			before(:each) do
				request.env["HTTP_REFERER"]="before"
				@user=create(:user)
				controller.session[:user_id]=@user.id
				put :update, {id: @user.id, user: FactoryGirl.attributes_for(:user, :email=>"try@email.com")}
				@user.reload
			end
			it "modifies the data" do
				expect(@user.email).to eq("try@email.com")
			end
			it "redirects to modified user" do
				expect(response).to redirect_to(@user)
			end
		end
		context "when user is admin and tries to modify someone's else data" do
			before(:each) do
				request.env["HTTP_REFERER"]="before"
				admin=create(:admin)
				controller.session[:user_id]=admin.id
				@user=create(:user)
				put :update, {:id => @user.id, :user => {:email => "try@email.com"}}
				@user.reload
			end
			it "modifies the data" do
				expect(@user.email).to eq("try@email.com")
			end
			it "redirects to modified user" do
				expect(response).to redirect_to(@user)
			end
		end
		context "when user tries to access someone's else data an is not admin" do
			before(:each) do
				@user=create(:user)
				@user2=create(:user2)
				controller.session[:user_id]=@user.id
				put :update, {:id => @user2.id, :user => {:email => "whatiwant@email.com"}}
			end
			it "doesn't modify the data" do
				expect(@user2.email).to_not eq("whatiwant@email.com")
			end
			it "redirects to a specific unauthorized page" do
				expect(response).to redirect_to("/unauthorized")
			end
		end
		context "when user sends invalid data" do
			before(:each) do
				request.env["HTTP_REFERER"]="before"
				@user=create(:user)
				controller.session[:user_id]=@user.id
				put :update, {:id => @user.id, :user => {:email => ""}}
			end
			it "doesn't modify the data" do
				expect(@user.email).to_not eq("")
			end
			it "redirects to back" do
				expect(response).to redirect_to("before")
			end
		end
		context "when user is not logged" do
			it "redirects to a specific unauthorized page" do
				user=create(:user)
				put :update, {:id => user.id, :user => {:email => "else@email.com"}}
				expect(response).to redirect_to("/unauthorized")
			end
		end
	end

	describe "DELETE destroy" do
		context "when user is logged and tries to destroy its account" do
			before(:each) do
				user=create(:user)
				personal=PersonalDatum.new
				personal.user=user
				personal.save
				controller.session[:user_id]=user.id
				delete :destroy, id: user.id
			end
			it "destroys its data" do
				expect(User.count).to eq(0)
			end
			it "destroys personal data if present" do
				expect(PersonalDatum.count).to eq(0)
			end
			it "destroys platform data" do
				expect(UserPlatformDatum.count).to eq(0)
			end
			it "destroys session" do
				expect(controller.session[:user_id]).to eq(nil)
			end
			it "redirect to home" do
				expect(response).to redirect_to("/")
			end
		end
		context "when user is admin" do
			before(:each) do
				user=create(:user)
				personal=PersonalDatum.new
				personal.user=user
				personal.save
				@admin=create(:admin)
				controller.session[:user_id]=@admin.id
				delete :destroy, id: user.id
			end
			it "destroys its data" do
				expect(User.count).to eq(1)
			end
			it "destroys personal data if present" do
				expect(PersonalDatum.count).to eq(0)
			end
			it "destroys platform data" do
				expect(UserPlatformDatum.count).to eq(1)
			end
			it "doesn't destroy session" do
				expect(controller.session[:user_id]).to eq(@admin.id)
			end
			it "redirect to home" do
				expect(response).to redirect_to("/")
			end
		end
		context "when someone tries to destroy another account and is not admin" do
			it "redirects to a specific unauthorized page" do
				user=create(:user)
				delete :destroy, :id => user.id
				expect(response).to redirect_to("/unauthorized")
			end
		end
	end

	describe "DELETE nick_destroy" do
		context "when user is admin and valid parameter is passed" do
			before(:each) do
				user=create(:user)
				personal=PersonalDatum.new
				personal.user=user
				personal.save
				@admin=create(:admin)
				controller.session[:user_id]=@admin.id
				delete :nick_destroy, nick: user.nickname
			end
			it "destroys its data" do
				expect(User.count).to eq(1)
			end
			it "destroys personal data if present" do
				expect(PersonalDatum.count).to eq(0)
			end
			it "destroys platform data" do
				expect(UserPlatformDatum.count).to eq(1)
			end
			it "redirect to administration page" do
				expect(response).to redirect_to("/admin")
			end
		end
		context "when user is admin but invalid parameter is passed" do
			it "redirect to administration page" do
				@admin=create(:admin)
				controller.session[:user_id]=@admin.id
				delete :nick_destroy, nick: "not exists"
				expect(response).to redirect_to("/admin")
			end
		end
		context "when user is not admin or not logged" do
			it "redirects to a specific unauthorized page" do
				user=create(:user)
				delete :nick_destroy, :nick => user.nickname
				expect(response).to redirect_to("/unauthorized")
			end
		end
	end

end
