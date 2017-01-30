require 'rails_helper'

RSpec.describe TransactionsController, :type=> :controller do
	describe "GET index" do
		context "when user is at least mod" do
			it "has a 200 status code" do
				user=build(:mod)
				user.save
				controller.session[:user_id]=user.id
				get :index
				expect(response.status).to eq(200)
			end
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
			it "has a status code different from 200"	do
				user=build(:user)
				user.save
				controller.session[:user_id]=user.id
				get :index
				expect(response.status).to_not eq(200)
			end
		end
	end


	describe "GET show"	do
		context "when user is logged" do
			it "has a 200 status code" do
				user=build(:user)
				user.save
				controller.session[:user_id]=user.id
				transaction=build(:transaction)
				transaction.save
				get :show, id: transaction
				expect(response.status).to eq(200)
			end
			it "renders the 'show' view" do
				user=build(:user)
				user.save
				controller.session[:user_id]=user.id
				transaction=build(:transaction)
				transaction.save
				get :show, id: transaction
				expect(response).to render_template("show")
			end
		end
		
		context "when user is not logged" do
			it "has a status code different from 200"	do
				transaction=build(:transaction)
				transaction.save
				get :show, id: transaction
				expect(response.status).to_not eq(200)
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
			it "has a 200 status code" do
				user=build(:user)
				user.save
				controller.session[:user_id]=user.id
				get :new
				expect(response.status).to eq(200)
			end
			it "renders the 'new' view" do
				user=build(:user)
				user.save
				controller.session[:user_id]=user.id
				get :new
				expect(response).to render_template("new")
			end
		end
		context "when user is not logged" do
			it "has a status code different from 200"	do
				get :new
				expect(response.status).to_not eq(200)
			end
		end
	end


	describe "POST create" do
	end


	describe "DELETE destroy" do
	end


end
