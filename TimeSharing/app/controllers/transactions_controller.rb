class TransactionsController < ApplicationController
	
	include SessionsHelper

  before_action :set_transaction, only: [:show, :destroy]


  def index
	check_auth(2)
	@admin=0
	if UserPlatformDatum.find_by(id: current_user.id).access==3 then @admin=1 end
    @transactions = Transaction.all
  end

  def show
  end

  def new
	@username=current_user.nickname
    @transaction = Transaction.new
  end

  def create
	if not User.exists?(nickname: params(:to))
		:notice="User not found. Try again"
	elsif UserPlatformDatum.find_by(user_id: User.find_by(nickname: params(:from)).id).amount<params(:amount)
		:notice="You have not enough hours to complete this transaction"
	elsif params(:amount)<0
		:notice="Hours must be not negative"
	else			
		@applicant=User.find_by(nickname: params(:from))
		@applicant=UserPlatformDatum.find_by(user_id: @applicant.id)
		@fullfiller=User.find_by(nickname: params(:to))
		@fullfiller=UserPlatformDatum.find_by(user_id: @fullfiller.id)
		@applicant.wallet-=params(:amount)
		@fullfiller.wallet+=params(:amount)
		@applicant.save
		@fullfiller.save
		@ad=Ad.find(params(:ad_id))
		@ad.closed=true
		@ad.save
		@transaction=Transaction.new(transaction_params)
		@transaction.save
		redirect_to :back
	end
  end

  def destroy
	check_auth(3)
	#Ritrova gli utenti
	@applicant=User.find_by(nickname: @transaction.from)
	@applicant=UserPlatformDatum.find_by(user_id: @applicant.id)
	@fullfiller=User.find_by(nickname: @transaction.to)
	@fullfiller=UserPlatformDatum.find_by(user_id: @fullfiller.id)

	#Ripristina lo stato precedente
	@applicant.wallet+=@transaction.amount
	@fullfiller.wallet-=@transaction.amount
	@applicant.save
	@fullfiller.save

	#Riapre l'annuncio
	@ad=Ad.find(@transaction.ad_id)
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
      params.require(:transaction).permit(:ad_id, :from, :to, :amount)
    end
end
