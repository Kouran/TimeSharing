class AdsController < ApplicationController

  include SessionsHelper

  before_action :set_ad, only: [:show, :edit, :update, :destroy]
  before_action :logged_in?, only: [:my, :new, :create, :edit, :update, :destroy]
  before_action :is_mod?, only: [:param_delete]
  respond_to :html

def search
end

def result
    parametro1=params[:search]
    parametro2=params[:search2]
    parametro3=params[:search3]
    parametro4=params[:search4]

    @ads = Ad.where("title LIKE ? and category LIKE ? and description LIKE ? and applicant_user LIKE ?", "%#{parametro1}%", "%#{parametro2}%", "%#{parametro3}%", "%#{parametro4}%").order("created_at DESC")
    render "index"
end

def my

    @ads = Ad.where("applicant_user LIKE ?", "%#{current_user.nickname}%")
	render "index"

end




  def index
    @ads = Ad.all
    #respond_with(@ads)
  end

  def show
    #  @applicant=User.find_by(nickname: @ad.applicant_user).id
    #respond_with(@ad)
  end

  def new
    @ad = Ad.new
    #respond_with(@ad)
  end

  def edit
	if not ((current_user.nickname==@ad.applicant_user and not @ad.closed) or check_auth(2)) then redirect_to "/unauthorized"  and return end
  end

  def create
      @ad = Ad.new(ad_params)
	  @ad.applicant_user=current_user.nickname
      if @ad.save
		redirect_to(@ad)
	  else
		redirect_to(:back)
	  end
  end

  def update
	if not ((current_user.nickname==@ad.applicant_user and not @ad.closed) or check_auth(2)) then redirect_to "/unauthorized"  and return end
	params[:ad].delete :applicant_user
    if @ad.update(ad_params)
		redirect_to(@ad)
	else
		redirect_to(:back)
	end
  end

  def destroy
      if not ((current_user.nickname==@ad.applicant_user and not @ad.closed) or check_auth(2)) then redirect_to "/unauthorized"  and return end
      @ad.destroy
      redirect_to "/ads" and return
  end

  def param_delete
	@ad = Ad.find_by(id: params[:id])
	@ad.destroy
    redirect_to "/mod" and return
  end

  private
    def set_ad
      @ad = Ad.find(params[:id])
    end

    def ad_params
      params.require(:ad).permit(:title, :category, :description, :expected_hours, :deadline, :closed, :applicant_user, :fullfiller_user)
    end
end
