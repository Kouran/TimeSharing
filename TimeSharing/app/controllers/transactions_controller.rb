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
	if not User.exists?(nickname: params(:to)) then redirect_to "/" and return
	elsif UserPlatformDatum.find_by(user_id: User.find_by(nickname: params(:from)).id).amount<params(:amount) then redirect_to "/" and return
	elsif params(:amount)<0 then redirect_to "/" and return
	else			
		@transaction=Transaction.new
		@applicant=User.find(current_user)
		@transaction.from=@applicant
		@applicant=UserPlatformDatum.find_by(user_id: @applicant.id)
		@fullfiller=User.find_by(nickname: params(:to))
		@transaction.to=@fullfiller
		@fullfiller=UserPlatformDatum.find_by(user_id: @fullfiller.id)
		@applicant.wallet-=params(:amount)
		@fullfiller.wallet+=params(:amount)
		@applicant.save
		@fullfiller.save
		@ad=Ad.find(params(:id))
		@transaction.ad=@ad
		@ad.closed=true
		@ad.save
		@transaction.amount=params[:amount]
		@transaction.save
		redirect_to @transaction
	end
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
	@ad.closed=false
	@ad.save

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
