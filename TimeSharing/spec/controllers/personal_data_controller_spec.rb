require 'rails_helper'

RSpec.describe PersonalDataController, :type=> :controller do
	describe "GET show" do
		context "when user is logged" do
			it "renders the personal data" do
				user=create(:user)
				controller.session[:user_id]=user.id
				data=create(:personaldatum)
				get :show, id: data.id
				expect(response).to render_template("show")
			end
		end
		context "when user is not logged" do
			it "redirects to specific unauthorized page" do
				data=create(:personaldatum)
				get :show, id: data.id
				expect(response).to redirect_to("/unauthorized")
			end
		end
	end

	describe "GET new" do
		context "when user is logged and he has no personal data" do
			before(:each) do
				user=create(:user)
				controller.session[:user_id]=user.id
				get :new
			end
			it "prepares the variable @personal_datum" do
				expect(assigns(:personal_datum)).to_not eq(nil)
			end
			it "renders the new form" do
				expect(response).to render_template("new")
			end
		end
		context "when user is logged and already has personal data" do
			it "redirects to the edit form for user's personal data" do
				user=create(:user)
				personal=create(:personaldatum)
				personal.user=user
				personal.save
				controller.session[:user_id]=user.id
				get :new
				expect(response).to redirect_to("/personal_data/#{personal.id}/edit")
			end
		end
		context "when user is not logged" do
			it "redirects to specific unauthorized page" do
				get :new
				expect(response).to redirect_to("/unauthorized")
			end
		end
	end

	describe "GET edit" do
		context "when user is logged" do
			it "renders the edit page" do
				user=create(:user)
				personal=create(:personaldatum)
				personal.user=user
				personal.save
				controller.session[:user_id]=user.id
				get :edit, id: personal.id
				expect(response).to render_template("edit")
			end
		end
		context "when user is not logged" do
			it "redirects to specific unauthorized page" do
				data=create(:personaldatum)
				get :edit, id: data.id
				expect(response).to redirect_to("/unauthorized")
			end
		end
	end

	describe "POST create" do
		context "when user is logged and has no personal data" do
			before(:each) do
				user=create(:user)
				controller.session[:user_id]=user.id
				post :create, :personal_datum => {:user_id => user.id, :name => "paolo"}
			end
			it "creates the personal data" do
				expect(PersonalDatum.count).to eq(1)
			end
			it "shows the personal data" do
				personal=PersonalDatum.first
				expect(response).to redirect_to(personal)
			end
		end
		context "when user is logged but already has personal data" do
			before(:each) do
				user=create(:user)
				@personal=create(:personaldatum)
				@personal.user=user
				@personal.save
				controller.session[:user_id]=user.id
				post :create, :personal_datum => {:user_id => user.id, :name => "paolo"}
			end
			it "does not create the personal data" do
				expect(PersonalDatum.count).to eq(1)
			end
			it "shows the personal data already created" do
				personal=PersonalDatum.first
				expect(response).to redirect_to(@personal)
			end
		end
		context "when user is not logged" do
			it "redirects to specific unauthorized page" do
				post :create
				expect(response).to redirect_to("/unauthorized")
			end
		end
	end
	
	describe "PUT update" do
		context "when user is logged and tries to modify its data" do
			before(:each) do
				user=create(:user)
				controller.session[:user_id]=user.id
				@personal=create(:personaldatum)
				@personal.user=user
				@personal.save
				put :update, id: @personal.id, personal_datum: {name: "paolo"}
				@personal.reload
			end
			it "modify personal data" do
				expect(@personal.name).to eq("paolo")
			end
			it "redirects to modified data" do
				expect(response).to redirect_to(@personal)
			end
		end
		context "when user is admin and tries to modify someone's else data" do
			before(:each) do
				user=create(:user)
				admin=create(:admin)
				controller.session[:user_id]=admin.id
				@personal=create(:personaldatum)
				@personal.user=user
				@personal.save
				put :update, id: @personal.id, personal_datum: {name: "paolo"}
				@personal.reload
			end
			it "modify user's data" do
				expect(@personal.name).to eq("paolo")
			end
			it "redirects to modified data" do
				expect(response).to redirect_to(@personal)
			end
		end
		context "when parameters are invalid" do
			before(:each) do
				user=create(:user)
				controller.session[:user_id]=user.id
				@personal=create(:personaldatum)
				@personal.user=user
				@personal.save
				put :update, id: @personal.id, personal_datum: {user_id: nil, name: "paolo"}
				@personal.reload
			end
			it "doesn't modify data" do
				expect(@personal.name).to_not eq("paolo")
			end
			it "renders edit page" do
				expect(response).to render_template("edit")
			end
		end
		context "when user is not logged or tries to modify someone's else data" do	
			it "redirects to specific unauthorized page" do
				personal=create(:personaldatum)
				put :update, id: personal.id
				expect(response).to redirect_to("/unauthorized")
			end
		end
	end
	
	describe "DELETE destroy" do
		context "when user tries to delete its data or is admin" do
			before(:each) do
				@user=create(:user)
				personal=create(:personaldatum)
				personal.user=@user
				personal.save
				controller.session[:user_id]=@user.id
				delete :destroy, id: personal.id
			end
			it "deletes the personal data" do
				expect(PersonalDatum.count).to eq(0)
			end
			it "redirects to user profile" do
				expect(response).to redirect_to(@user)
			end
		end
		context "when user tries to delete someone's else data or is not logged" do
			it "redirects to specific unauthorized page" do
				personal=create(:personaldatum)
				delete :destroy, id: personal.id
				expect(response).to redirect_to("/unauthorized")
			end
		end
	end

end
