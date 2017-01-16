class UserPlatformDataController < ApplicationController
  before_action :set_user_platform_datum, only: [:show]

	include SessionsHelper

  # GET /user_platform_data/1
  def show
	@user=User.find_by(id: @user_platform_datum.user_id)
  end

  # GET /user_platform_data/new
  def new
    if current_user==nil then redirect_to "/" and return end
	@userid=current_user
	if UserPlatformDatum.exists?(user_id: @userid) then redirect_to "/" and return end
    @user_platform_datum = UserPlatformDatum.new
	redirect_to "/"
  end

  # POST /user_platform_data
  def create
    @user_platform_datum = UserPlatformDatum.new(user_platform_datum_params)
	@user_platform_datum.access=1
	@user_platform_datum.fullfilling_rating=0
	@user_platform_datum.applying_rating=0
	@user_platform_datum.total_rating=0
	@user_platform_datum.wallet=2
    redirect_to @user_platform_datum
  end

  def permission
	check_auth(3)
	@user=User.find_by(nickname: params[:nick])
	@data=UserPlatformDatum.find_by(user_id: @user.id)
	@data.access=params[:permission]
	@data.save
  end

  def wallet
	check_auth(3)
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
      params.require(:user_platform_datum).permit(:user_id, :access, :fullfilling_rating, :applying_rating, :total_rating, :wallet)
    end
end
