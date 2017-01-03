class TransactionsController < ApplicationController
  before_action :set_transaction, only: [:show, :destroy]

  respond_to :html

  def index
    @transactions = Transaction.all
    respond_with(@transactions)
  end

  def show
    respond_with(@transaction)
  end

  def new
    @transaction = Transaction.new
    respond_with(@transaction)
  end

  def create
	if not User.exists?(nickname: params(:fullfiller))
		:notice="Attenzione, utente non trovato. Controllare eventuali errori di battitura"
	#AGGIUNGERE PORTAFOGLI	
#elsif User.find_by(nickname: params(:applicant)).ore<params(:amount)
		#:notice="Attenzione, l'importo in suo possesso è insufficiente a coprire la transazione"
	elsif params(:amount)<0
		:notice="Impossibile trasferire una quantità negativa di ore"
	else				
		@transaction=Transaction.new(transaction_params)
		@transaction.save
		@ad=Ad.find(@transaction.ad_id)
		@ad.closed=true
		@ad.save
		redirect_to :back
  end

  def destroy
	#Ritrova gli utenti
	@applicant=User.find_by(nickname: @transaction.from)
	@fullfiller=User.find_by(nickname: @transaction.to)

	#Ripristina lo stato precedente
	@applicant.ore+=@transaction.amount
	@fullfiller.ore-=@transaction.amount
	@applicant.save
	@fullfiller.save

	#Riapre l'annuncio
	@ad=Ad.find(@transaction.ad_id)
	@ad.closed=false
	@ad.save

	#Elimina la transazione
	@transaction.delete
	redirect_to "/admins/admin_transactions"
  end

  private
    def set_transaction
      @transaction = Transaction.find(params[:id])
    end

    def transaction_params
      params.require(:transaction).permit(:ad_id, :from, :to, :amount)
    end
end
