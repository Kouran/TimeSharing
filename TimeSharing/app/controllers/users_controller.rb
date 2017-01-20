class UsersController < ApplicationController

	include SessionsHelper
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
	@user=User.find(params[:id])
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)
      if @user.save
	log_in @user
	flash[:success]="Welcome to TimeSharing!"
	redirect_to @user
      else
	flash[:danger]="Attention! Wrong data"
	render "new"
      end
  end

  # PATCH/PUT /users/1
  def update
	if not current_user==params[:id] then check_auth(3) end
	@user.update(user_params)
  end

  # DELETE /users/1
  def destroy
	if not current_user==params[:id] then check_auth(3) end
	@userplatformdata=UserPlatformDatum.find_by(user_id: @user.id)
	@personaldata=PersonalDatum.find_by(user_id: @user.id)
	@userplatformdata.destroy
	@personaldata.destroy
    @user.destroy
  end

  def nick_destroy
	check_auth(3)
	@user=User.find_by(nickname: params[:nick])
	@userplatformdata=UserPlatformDatum.find_by(user_id: @user.id)
	@personaldata=PersonalDatum.find_by(user_id: @user.id)
	@userplatformdata.destroy
	@personaldata.destroy
    @user.destroy
  end
		

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:nickname, :email, :password, :password_confirmation, :created_at)
    end
end
