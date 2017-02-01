class AdsController < ApplicationController

  include SessionsHelper

  before_action :set_ad, only: [:show, :edit, :update, :destroy]
  before_action :logged_in?, only: [:my]
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
    respond_with(@ad)
  end

  def edit
  end

  def create
      @ad = Ad.new(ad_params)
      @ad.save

     respond_with(@ad)
  end

  def update
    @ad.update(ad_params)
    respond_with(@ad)
  end

  def destroy
      if not current_user.nickname==Ad.find(params[:id]).applicant_user or check_auth(2) then redirect_to "/unauthorized"  and return end
      @ad.destroy
      redirect_to "/ads" and return
  end

  def param_delete
	@ad = Ad.find_by(id: params[:id])
	@ad.destroy
    redirect_to "/ads" and return
  end

  private
    def set_ad
      @ad = Ad.find(params[:id])
    end

    def ad_params
      params.require(:ad).permit(:title, :category, :description, :zone, :expected_hours, :deadline, :request, :closed, :applicant_user, :fullfiller_user)
    end
end
