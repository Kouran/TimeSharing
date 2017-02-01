class TransactionsController < ApplicationController

	include SessionsHelper

	before_action :logged_in?
	before_action :set_transaction, only: [:show, :destroy]
	before_action :is_mod?, only: [:index]
	before_action :is_admin?, only: [:destroy]


  def index
	@admin=0
	if UserPlatformDatum.find_by(id: current_user.id).access==3 then @admin=1 end
    @transactions = Transaction.all
  end

  def show
  end

  def new
    @transaction = Transaction.new
  end

  def create
	if not User.find_by(nickname: params[:transaction][:to]) then redirect_to "/" and return end
	if UserPlatformDatum.find_by(user_id: current_user.id).wallet<params[:transaction][:amount].to_i then redirect_to "/" and return end
	if params[:transaction][:amount].to_i<0 then redirect_to "/" and return end
	@transaction=Transaction.new
	@applicant=current_user
	@transaction.from=@applicant
	@applicant=UserPlatformDatum.find_by(user_id: @applicant.id)
	@fullfiller=User.find_by(nickname: params[:transaction][:to])
	@transaction.to=@fullfiller
	@fullfiller=UserPlatformDatum.find_by(user_id: @fullfiller.id)
	@applicant.wallet-=params[:transaction][:amount].to_i
	@fullfiller.wallet+=params[:transaction][:amount].to_i
	@applicant.save
	@fullfiller.save
	@ad=Ad.find(params[:transaction][:ad])
	@transaction.ad=@ad
	@ad.fullfiller_user=params[:transaction][:to]
	@ad.closed=true
	@ad.save
	@transaction.amount=params[:transaction][:amount].to_i
	@transaction.save
	redirect_to "/ads"
  end

  def destroy
	#Ritrova gli utenti
	@applicant=@transaction.from
	@applicant=UserPlatformDatum.find_by(user_id: @applicant.id)
	@fullfiller=@transaction.to
	@fullfiller=UserPlatformDatum.find_by(user_id: @fullfiller.id)

	#Ripristina lo stato precedente
	@applicant.wallet+=@transaction.amount
	@fullfiller.wallet-=@transaction.amount
	@applicant.save
	@fullfiller.save

	#Riapre l'annuncio
	@ad=@transaction.ad
	if @ad
		@ad.closed=false
		@ad.save
	end

	#Elimina la transazione
	@transaction.delete
	redirect_to "/transactions"
  end

  private
    def set_transaction
      @transaction = Transaction.find(params[:id])
    end

    def transaction_params
      params.require(:transaction).permit(:ad, :from, :to, :amount)
    end
end
