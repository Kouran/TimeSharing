class UserPlatformDataController < ApplicationController
	before_action :set_user_platform_datum, only: [:show]
	before_action :is_admin?, only: [:permission, :wallet]

	include SessionsHelper

  # GET /user_platform_data/1
  def show
  end

  def permission
	@user=User.find_by(nickname: params[:nick])
	@data=UserPlatformDatum.find_by(user_id: @user.id)
	@data.access=params[:permission]
	@data.save
  end

  def wallet
	@user=User.find_by(nickname: params[:nick])
	@data=UserPlatformDatum.find_by(user_id: @user.id)
	@data.wallet+=params[:amount]
	@data.save
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
