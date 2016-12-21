class AdsController < ApplicationController
  before_action :set_ad, only: [:show, :edit, :update, :destroy]

  respond_to :html

def search
end

def result
    parametro1=params[:search]
    parametro2=params[:search2]
    parametro3=params[:search3]
    parametro4=params[:search4]

    @annuncios = Annuncio.where("titolo LIKE ? and categoria LIKE ? and descrizione LIKE ? and utente_richiedente LIKE ?", "%#{parametro1}%", "%#{parametro2}%", "%#{parametro3}%", "%#{parametro4}%").order("created_at DESC")
end

def my
    @annuncios = Annuncio.where("utente_richiedente LIKE ?", "%#{id}%")

end


  def index
    @ads = Ad.all
    respond_with(@ads)
  end

  def show
    respond_with(@ad)
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
    @ad.destroy
    respond_with(@ad)
  end

  private
    def set_ad
      @ad = Ad.find(params[:id])
    end

    def ad_params
      params.require(:ad).permit(:title, :category, :description, :zone, :expected_hours, :deadline, :request, :closed, :applicant_user, :fullfiller_user)
    end
end