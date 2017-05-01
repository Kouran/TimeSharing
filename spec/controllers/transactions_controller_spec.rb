require 'rails_helper'

RSpec.describe TransactionsController, :type=> :controller do

	describe "GET index" do
		context "when user is at least mod" do
			it "assigns @transactions" do
				user=build(:mod)
				user.save
				controller.session[:user_id]=user.id
				transaction=build(:transaction)
				transaction.save
				get :index
				expect(assigns(:transactions)).to eq([transaction])
			end
			it "renders the 'index' view" do
				user=build(:mod)
				user.save
				controller.session[:user_id]=user.id
				get :index
				expect(response).to render_template("index")
			end
		end
		context "when user is not logged or unauthorized" do
			it "redirects to a specific unauthorized page" do
				get :new
				expect(response).to redirect_to("/unauthorized")
			end
		end
	end


	describe "GET show"	do
		context "when user is at least mod" do
			it "renders the 'show' view" do
				user=build(:mod)
				user.save
				controller.session[:user_id]=user.id
				transaction=build(:transaction)
				transaction.save
				get :show, id: transaction
				expect(response).to render_template("show")
			end
		end
		context "when user is not logged or not a mod" do
			it "redirects to a specific unauthorized page" do
				get :new
				expect(response).to redirect_to("/unauthorized")
			end
		end
		context "when transaction does not exist" do
			it "has a status code different from 200" do
				get :show, id: 222
				expect(response.status).to_not eq(200)
			end
		end
	end


	describe "GET new" do
		context "when user is logged" do
			it "renders the 'new' view" do
				user=build(:user)
				user.save
				controller.session[:user_id]=user.id
				get :new
				expect(response).to render_template("new")
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
		context "when user is logged and with valid parameters" do
			before(:each) do
				@user=create(:user)
				@plat=create(:user_data)
				@user.plat=@plat
				controller.session[:user_id]=@user.id
				@user2=create(:user2)
				@plat2=create(:user_data)
				@user2.plat=@plat2
				@ad=create(:ad)
				post :create, {:transaction => {:to => @user2.nickname, :ad => @ad.id, :amount => "1"}}
				@user.reload
				@user2.reload
				@ad.reload
			end
			it "creates the transaction" do
				expect(Transaction.count).to eq(1)
				end
			it "moves the amount from applicant to fullfiller" do
				expect(@user.plat.wallet-@user2.plat.wallet).to eq(-2)
			end
			it "sets the ad to closed" do
				expect(@ad.closed).to eq(true)
			end
			it "redirects to the ads" do
				expect(response).to redirect_to("/ads")
				end
		end
		context "when user is logged but parameters are invalid" do
			before(:each) do
				request.env["HTTP_REFERER"]="before"
				user=create(:user)
				controller.session[:user_id]=user.id
				ad=create(:ad)
				post :create, {:transaction => {:to => "caio", :ad => ad.id, :amount => "1"}}
			end
			it "does not create the transaction" do
				expect(Transaction.count).to eq(0)
				end
			it "redirects to back" do
				expect(response).to redirect_to("before")
				end
		end
		context "when user is not logged" do
			it "redirects to a specific unauthorized page" do
				user=create(:user)
				user2=create(:user2)
				ad=create(:ad)
				post :create, {:transaction => {:to => user2.nickname, :ad => ad.id, :amount => "1"}}
				expect(response).to redirect_to("/unauthorized")
			end
		end
	end


	describe "DELETE destroy" do
		context "when user is logged and with valid parameters" do
			before(:each) do
				@user=create(:admin)
				controller.session[:user_id]=@user.id
				@transaction=create(:transaction)
				@from=@transaction.from
				@to=@transaction.to
				@ad=@transaction.ad
				delete :destroy, {:id => @transaction.id}
			end
			#it "removes the transaction"
			#it "moves the amount from fullfiller to applicant"
			#it "sets the ad to not closed"
			#it "redirects to the ads"
		end
		context "when user is not logged" do
			it "redirects to a specific unauthorized page" do
				user=create(:user)
				user2=create(:user2)
				ad=create(:ad)
				post :create, {:transaction => {:to => user2.nickname, :ad => ad.id, :amount => "1"}}
				expect(response).to redirect_to("/unauthorized")
			end
		end
	end
end
