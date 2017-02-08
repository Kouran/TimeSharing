class MessagesController < ApplicationController
	include SessionsHelper
  before_action :logged_in?, only: [:index, :show, :new, :edit, :crate, :update, :destroy, :admin_report]
  before_action :set_message, only: [:show, :edit, :update, :destroy]
  before_action :is_admin?, only: [:admin, :destroy]
  before_action :is_mod?, only: [:mod]
	
  # GET /messages
  def index
		#@messages= Message.find_by(sender: current_user)
		@user=User.find(current_user).nickname
		@messages = Message.where("sender = ? OR receiver = ? ", @user, @user) 
		if params[:search]
			@messages=Message.search(params[:search]).order("created_at DESC") 
		end
	end

  # GET /messages/1
  def show
	if not ((current_user.nickname==@message.sender) or (current_user.nickname==@message.receiver) or check_auth(3)) then redirect_to "/unauthorized" and return end
  end

  # GET /messages/new
  def new
    @message = Message.new 	
  end

  # POST /messages
  def create
    @message = Message.new(message_params)
    if @message.save
        redirect_to @message
    else
        render :new
    end
  end

  # DELETE /messages/1
  def destroy
    @message.destroy
    redirect_to messages_url
  end

	def admin_report	
		@message = Message.new
		if @message.receiver == "admin" then
			@message = Message.new(adm_message_params)
		end
		if @message.receiver == "mod" then 
			@message = Message.new(mod_message_params)
		end

    end

	def admin
		@messages = Message.where(receiver: "admin")
	end
  	
	def mod
		@messages = Message.where(receiver: "mod")
	end



	private
    # Use callbacks to share common setup or constraints between actions.
    def set_message
		@message= Message.find(params[:id])  
	end
	
    # Never trust parameters from the scary internet, only allow the white list through.
    def message_params
      params.require(:message).permit(:sender, :receiver, :title, :body)
    end

	def adm_message_params        
		params.require(:message).permit(:sender, "admin", :title, :body)
    end
	def mod_message_params        
		params.require(:message).permit(:sender, "mod", :title, :body)
    end
	

end
