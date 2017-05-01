class UserPlatformDataController < ApplicationController
	before_action :set_user_platform_datum, only: [:show]
	before_action :is_admin?, only: [:permission, :wallet]

	include SessionsHelper

  # GET /user_platform_data/1
  def show
  end

  def permission
	if not @user=User.find_by(nickname: params[:nick]) then redirect_to "/admin" and return end
	@user.plat.access=params[:permission]
	@user.plat.save
	redirect_to "/admin"
  end

  def wallet
	if not @user=User.find_by(nickname: params[:nick]) then redirect_to "/admin" and return end
	@user.plat.wallet+=params[:amount].to_i
	@user.plat.save
	redirect_to "/admin"
  end
  

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user_platform_datum
      @user_platform_datum = UserPlatformDatum.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_platform_datum_params
      params.require(:user_platform_datum).permit(:user_id, :access, :wallet)
    end
end
