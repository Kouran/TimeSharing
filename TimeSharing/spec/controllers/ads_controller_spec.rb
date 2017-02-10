require 'rails_helper'

RSpec.describe AdsController, :type=> :controller do
	describe "GET search" do
		it "renders the 'search' page" do
			get :search
			expect(response).to render_template('search')
		end
	end

	describe "GET result" do
		context "when parameters are valid" do
			before(:each) do
				@ad=create(:ad)
				get :result, search: "Titolo", search2: "", search3: "", search4: ""
			end
			it "assigns results to @ads" do
				expect(assigns[:ads]).to eq([@ad])
			end
			it "renders index" do
				expect(response).to render_template('index')
			end
		end
		context "when parameters are invalid" do
			before(:each) do
				@ad=create(:ad)
				get :result, search: "Non titolo", search2: "", search3: "", search4: ""
			end
			it "asigns empty array to @ads" do
				expect(assigns[:ads]).to eq([])
			end
			it "renders index" do
				expect(response).to render_template('index')
			end
		end
	end

	describe "GET my" do
		context "when user is logged" do
			before(:each) do
				user=create(:user)
				@ad=create(:ad)
				@ad.applicant_user=user.nickname
				@ad.save
				controller.session[:user_id]=user.id
				get :my
			end
			it "assigns user's ads to @ads" do
				expect(assigns[:ads]).to eq([@ad])
			end
			it "renders index" do
				expect(response).to render_template('index')
			end
		end
		context "when user is not logged" do
			it "redirects to a specific unauthorized page" do
				get :my
				expect(response).to redirect_to("/unauthorized")
			end
		end
	end

	describe "GET index" do
		before(:each) do
			@ad=create(:ad)
			get :index
		end
		it "assigns all ads to @ads" do
			expect(assigns[:ads]).to eq([@ad])
		end
		it "renders index" do
			expect(response).to render_template('index')
		end
	end

	describe "GET show" do
		it "renders the ad" do
			@ad=create(:ad)
			user=create(:user)
			@ad.applicant_user=user.nickname
			@ad.save
			get :show, id: @ad.id
			expect(response).to render_template('show')
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
		
	describe "GET edit" do
		context "when user tries to edit its own ad and the ad is not closed" do
			it "renders the edit page" do
				user=create(:user)
				controller.session[:user_id]=user.id
				ad=create(:ad)
				ad.applicant_user=user.nickname
				ad.save
				get :edit, id: ad.id
				expect(response).to render_template('edit')
			end
		end
		context "when mod tries to edit someone's else ad" do
			it "renders the edit page" do
				user=create(:mod)
				controller.session[:user_id]=user.id
				ad=create(:ad)
				ad.save
				get :edit, id: ad.id
				expect(response).to render_template('edit')
			end
		end
		context "when user tries to edit someone's else ad" do	
			it "redirects to a specific unauthorized page" do
				user=create(:user)
				controller.session[:user_id]=user.id
				ad=create(:ad)
				ad.save
				get :edit, id: ad.id
				expect(response).to redirect_to("/unauthorized")
			end		
		end
		context "when user tries to edit its own closed ad" do
			it "redirects to a specific unauthorized page" do
				user=create(:user)
				controller.session[:user_id]=user.id
				ad=create(:ad)
				ad.applicant_user=user.nickname
				ad.closed=true
				ad.save
				get :edit, id: ad.id
				expect(response).to redirect_to("/unauthorized")
			end
		end
		context "when user is not logged" do
			it "redirects to a specific unauthorized page" do
				ad=create(:ad)
				get :edit, id: ad.id
				expect(response).to redirect_to("/unauthorized")
			end
		end
	end

	describe "POST create" do
		context "when user is logged and parameters are valid" do
			before(:each) do
				@user=create(:user)
				controller.session[:user_id]=@user.id
				post :create, ad: FactoryGirl.attributes_for(:ad)
			end				
			it "creates a new ad" do
				expect(Ad.count).to eq(1)
			end
			it "assigns user's nickname as applicant, regardless of applicant_user post field" do
				expect(Ad.first.applicant_user).to eq(@user.nickname)
			end
			it "redirects to the created ad" do
				expect(response).to redirect_to(Ad.first)
			end
		end
		context "when user is logged but parameters are invalid" do
			before(:each) do
				request.env["HTTP_REFERER"]="before"
				@user=create(:user)
				controller.session[:user_id]=@user.id
				params=FactoryGirl.attributes_for(:ad)
				params.delete :title
				post :create, ad: params 
			end		
			it "does not create the ad" do
				expect(Ad.count).to eq(0)
			end
			it "redirects to previous page" do
				expect(response).to redirect_to("before")
			end 
		end
		context "when user is not logged" do
			it "redirects to a specific unauthorized page" do
				post :create, ad: FactoryGirl.attributes_for(:ad)
				expect(response).to redirect_to("/unauthorized")
			end
		end
	end

	describe "PUT update" do
		context "when user is owner or mod and tries to modify ad with valid parameters" do
			before(:each) do
				request.env["HTTP_REFERER"]="before"
				user=create(:user)
				controller.session[:user_id]=user.id
				@ad=create(:ad)
				@ad.applicant_user=user.nickname
				@ad.save
				params={title: "Else", applicant_user: "Someone"}
				put :update, id: @ad.id, ad: params 
				@ad.reload
			end	
			it "modifies the ad" do
				expect(@ad.title).to eq("Else")
			end
			it "keeps the applicant untouched, regardless of post attribute" do
				expect(@ad.applicant_user).to_not eq("Someone")
			end
			it "redirects to the modified ad" do
				expect(response).to redirect_to(@ad)
			end
		end
		context "when user is authorized but parameters are invalid" do
			before(:each) do
				request.env["HTTP_REFERER"]="before"
				user=create(:user)
				controller.session[:user_id]=user.id
				@ad=create(:ad)
				@ad.applicant_user=user.nickname
				@ad.save
				params={expected_hours: "NaN"}
				put :update, id: @ad.id, ad: params
				@ad.reload 
			end		
			it "does not modify the ad" do
				expect(@ad.title).to eq("Titolo")
			end
			it "redirects to previous page" do
				expect(response).to redirect_to("before")
			end 
		end
		context "when user tries to modify someone's else data" do
			it "redirects to a specific unauthorized page" do
				user=create(:user)
				controller.session[:user_id]=user.id
				target=create(:ad)
				put :update, id: target.id, ad: FactoryGirl.attributes_for(:ad)
				expect(response).to redirect_to("/unauthorized")
			end
		end
		context "when user is not logged" do
			it "redirects to a specific unauthorized page" do
				target=create(:ad)
				put :update, id: target.id, ad: FactoryGirl.attributes_for(:ad)
				expect(response).to redirect_to("/unauthorized")
			end
		end
	end

	describe "DELETE destroy" do
		context "when user tries to destroy its ad and it's not closed" do
			before(:each) do
				user=create(:user)
				target=create(:ad)
				target.applicant_user=user.nickname
				target.save
				controller.session[:user_id]=user.id
				delete :destroy, id: target.id
			end
			it "destroys the ad" do
				expect(Ad.count).to eq(0)
			end
			it "redirects to ads" do
				expect(response).to redirect_to("/ads")
			end
		end
		context "when mod tries to destroy an ad" do
			before(:each) do
				user=create(:mod)
				target=create(:ad)
				controller.session[:user_id]=user.id
				delete :destroy, id: target.id
			end
			it "destroys the ad" do
				expect(Ad.count).to eq(0)
			end
			it "redirects to ads" do
				expect(response).to redirect_to("/ads")
			end
		end
		context "when user tries to destroy someone's else ad or its own closed ad" do
			before(:each) do
				user=create(:user)
				target=create(:ad)
				target.applicant_user=user.nickname
				target.closed=true
				target.save
				delete :destroy, id: target.id
			end
			it "does not destroy the ad" do
				expect(Ad.count).to eq(1)
			end
			it "redirects to a specific unauthorized page" do
				expect(response).to redirect_to("/unauthorized")
			end
		end
		context "when user is not logged" do
			it "redirects to a specific unauthorized page" do
				target=create(:ad)
				delete :destroy, id: target.id
				expect(response).to redirect_to("/unauthorized")
			end
		end
	end

	describe "POST param_delete" do
		context "when user is mod" do
			before(:each) do
				user=create(:mod)
				target=create(:ad)
				controller.session[:user_id]=user.id
				post :param_delete, id: target.id
			end
			it "destroys the ad" do
				expect(Ad.count).to eq(0)
			end
			it "redirects to moderation page" do
				expect(response).to redirect_to("/mod")
			end
		end
		context "when user is not mod" do
			it "redirects to a specific unauthorized page" do
				target=create(:ad)
				post :destroy, id: target.id
				expect(response).to redirect_to("/unauthorized")
			end
		end
	end

end
