require 'rails_helper'

RSpec.describe UserPlatformDataController, :type=> :controller do
	describe "GET show" do
		context "when parameter is valid" do
			it "renders the platform data" do
				plat=create(:user_data)
				get :show, id: plat.id
				expect(response).to render_template('show')
			end
		end
	end

	describe "PUT permission" do
		context "when user is admin and parameters are valid" do
			before(:each) do
				@user=create(:user)
				admin=create(:admin)
				controller.session[:user_id]=admin.id
				put :permission, {:nick=>@user.nickname, :permission=>2}
				@user.reload
			end
			it "modify permission of user" do
				expect(@user.plat.access).to eq(2)
			end
			it "redirects to administration page" do
				expect(response).to redirect_to("/admin")
			end
		end
		context "when user is admin but parameters are invalid" do
			before(:each) do
				@user=create(:user)
				admin=create(:admin)
				controller.session[:user_id]=admin.id
				put :permission, {:nick=>@user.nickname, :permission=>5}
				@user.reload
			end
			it "doesn't modify permission of user" do
				expect(@user.plat.access).to eq(1)
			end
			it "redirects to administration page" do
				expect(response).to redirect_to("/admin")
			end
		end
		context "when user is not admin or not logged" do
			it "redirects to specific unauthorized page" do
				user=create(:user)
				controller.session[:user_id]=user.id
				put :permission, {:nick=>user.nickname, :permission=>2}
				expect(response).to redirect_to("/unauthorized")
			end
		end
	end

	describe "PUT wallet" do
		context "when user is admin and parameters are valid" do
			before(:each) do
				@user=create(:user)
				admin=create(:admin)
				controller.session[:user_id]=admin.id
				put :wallet, {:nick=>@user.nickname, :amount=>"2"}
				@user.reload
			end
			it "modify wallet of user" do
				expect(@user.plat.wallet).to eq(4)
			end
			it "redirects to administration page" do
				expect(response).to redirect_to("/admin")
			end
		end
		context "when user is admin but parameters are invalid" do
			before(:each) do
				@user=create(:user)
				admin=create(:admin)
				controller.session[:user_id]=admin.id
				put :wallet, {:nick=>@user.nickname, :amount=>"NaN"}
				@user.reload
			end
			it "doesn't modify wallet of user" do
				expect(@user.plat.wallet).to eq(2)
			end
			it "redirects to administration page" do
				expect(response).to redirect_to("/admin")
			end
		end
		context "when user is not admin or not logged" do
			it "redirects to specific unauthorized page" do
				user=create(:user)
				controller.session[:user_id]=user.id
				put :wallet, {:nick=>user.nickname, :wallet=>2}
				expect(response).to redirect_to("/unauthorized")
			end
		end
	end
end
