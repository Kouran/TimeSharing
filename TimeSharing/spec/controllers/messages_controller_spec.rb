require 'rails_helper'

RSpec.describe MessagesController, :type=> :controller do
	describe "GET index" do
		context "when user is logged" do
			before(:each) do
				user=create(:user)
				controller.session[:user_id]=user.id
				@first=create(:message)
				@first.sender=user.nickname
				@first.save
				@last=create(:message)
				@last.receiver=user.nickname
				@last.save
				get :index
			end
			it "assigns @messages" do
				expect(assigns[:messages]).to exist
			end
			it "shows user's sent messages" do
				expect(assigns[:messages]).to include(@first)
			end
			it "shows user's received messages" do
				expect(assigns[:messages]).to include(@last)
			end
			it "renders the index" do
				expect(response).to render_template('index')
			end
		end
		context "when user is logged and search something" do
			before(:each) do
				user=create(:user)
				controller.session[:user_id]=user.id
				@first=create(:message)
				@first.sender=user.nickname
				@first.title="this"
				@first.save
				@last=create(:message)
				@last.receiver=user.nickname
				@last.save
				@other=create(:message)
				@other.title="this"
				@other.save
				get :index, search: "this"
			end
			it "assigns @messages" do
				expect(assigns[:messages]).to exist
			end
			it "shows the message with matching word" do
				expect(assigns[:messages]).to include(@first)
			end
			it "doesn't show non matching message owned by user" do
				expect(assigns[:messages]).to_not include(@last)
			end
			it "doesn't show matching message not owned by user" do
				expect(assigns[:messages]).to_not include(@other)
			end
			it "renders the index" do
				expect(response).to render_template('index')
			end
		end
		context "when user is not logged" do
			it "redirects to a specific unauthorized page" do
				get :index
				expect(response).to redirect_to("/unauthorized")
			end
		end
	end

	describe "GET show" do
		context "when user is sender, receiver or admin" do
			it "shows the message" do
				user=create(:user)
				controller.session[:user_id]=user.id
				message=create(:message)
				message.sender=user.nickname
				message.save
				get :show, id: message.id
				expect(response).to render_template('show')
			end
		end
		context "when user is not authorized" do
			it "redirects to a specific unauthorized page" do
				user=create(:user)
				controller.session[:user_id]=user.id
				message=create(:message)
				get :show, id: message.id
				expect(response).to redirect_to("/unauthorized")
			end
		end
		context "when user is not logged" do
			it "redirects to a specific unauthorized page" do
				message=create(:message)
				get :show, id: message.id
				expect(response).to redirect_to("/unauthorized")
			end
		end
	end

	describe "GET new" do
		context "when user is logged" do
			it "renders the new page" do
				user=create(:user)
				controller.session[:user_id]=user.id
				get :new
				expect(response).to render_template('new')
			end
		end
		context "when user is not logged" do
			it "redirects to a specific unauthorized page" do
				get :new
				expect(response).to redirect_to("/unauthorized")
			end
		end
	end

	describe "POST create" do
		context "when user is logged and parameters are valid" do
			before(:each) do
				@user=create(:user)
				controller.session[:user_id]=@user.id
				post :create, message: FactoryGirl.attributes_for(:message)
			end
			it "creates the message" do
				expect(Message.count).to eq(1)
			end
			it "assigns user's nickname to sender regardless of post parameter" do
				expect(Message.first.sender).to eq(@user.nickname)
			end
			it "redirects to the message" do
				expect(response).to redirect_to(Message.first)
			end
		end
		context "when user is logged but parameters are invalid" do
			before(:each) do
				@user=create(:user)
				controller.session[:user_id]=@user.id
				params=FactoryGirl.attributes_for(:message)
				params.delete :receiver
				post :create, message: params
			end
			it "doesn't create the message" do
				expect(Message.count).to eq(0)
			end
			it "renders the new page" do
				expect(response).to render_template('new')
			end
		end
		context "when user is not logged" do
			it "redirects to a specific unauthorized page" do
				post :create, message: FactoryGirl.attributes_for(:message)
				expect(response).to redirect_to("/unauthorized")
			end
		end
	end

	describe "DELETE destroy" do
		context "when user is admin" do
			before(:each) do
				user=create(:admin)
				controller.session[:user_id]=user.id
				message=create(:message)
				delete :destroy, id: message.id
			end
			it "deletes the message" do
				expect(Message.count).to eq(0)
			end
			it "redirects to administration page" do
				expect(response).to redirect_to("/admin")
			end
		end
		context "when user is not admin or not logged" do
			before(:each) do
				user=create(:user)
				controller.session[:user_id]=user.id
				message=create(:message)
				message.sender=user.nickname
				message.save
				delete :destroy, id: message.id
			end
			it "doesn't delete the message" do
				expect(Message.count).to eq(1)
			end
			it "redirects to a specific unauthorized page" do
				expect(response).to redirect_to("/unauthorized")
			end
		end
	end

	describe "GET admin_report" do
		context "when user is logged" do
			it "renders the admin report page" do
				user=create(:user)
				controller.session[:user_id]=user.id
				get :admin_report
				expect(response).to render_template('admin_report')
			end
		end
		context "when user is not logged" do
			it "redirects to a specific unauthorized page" do
				get :admin_report
				expect(response).to redirect_to("/unauthorized")
			end
		end
	end

	describe "GET admin" do
		context "when user is admin" do
			before(:each) do
				user=create(:admin)
				controller.session[:user_id]=user.id
				@message=create(:message)
				@message.receiver="admin"
				@message.save
				get :admin
			end
			it "assigns @messages" do
				expect(assigns[:messages]).to be
			end
			it "@messages contains messages sent to admin" do
				expect(assigns[:messages]).to include(@message)
			end
			it "renders the admin report page" do
				expect(response).to render_template('admin')
			end
		end
		context "when user is not admin or not logged" do
			it "redirects to a specific unauthorized page" do
				get :admin
				expect(response).to redirect_to("/unauthorized")
			end
		end
	end

	describe "GET mod" do
		context "when user is mod" do
			before(:each) do
				user=create(:mod)
				controller.session[:user_id]=user.id
				@message=create(:message)
				@message.receiver="mod"
				@message.save
				get :mod
			end
			it "assigns @messages" do
				expect(assigns[:messages]).to be
			end
			it "@messages contains messages sent to admin" do
				expect(assigns[:messages]).to include(@message)
			end
			it "renders the admin report page" do
				expect(response).to render_template('mod')
			end
		end
		context "when user is not mod or not logged" do
			it "redirects to a specific unauthorized page" do
				get :mod
				expect(response).to redirect_to("/unauthorized")
			end
		end
	end
end
