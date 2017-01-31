class MessagesController < ApplicationController
	include SessionsHelper
  before_action :logged_in?, only: [:index]#, notice => 'You re not logged'
	#before_action :redirect_to_root, :if => :logged_in?, :only => :index
  before_action :set_message, only: [:show, :edit, :update, :destroy]
  before_action :is_admin?, only: [:admin]
	
  # GET /messages
  # GET /messages.json
  def index
		#@messages= Message.find_by(sender: current_user)
		@user=User.find(current_user).nickname
		@messages = Message.where("sender = ? OR receiver = ? ", @user, @user) 
		if params[:search]
			@messages=Message.search(params[:search]).order("created_at DESC") 
		end
	end

  # GET /messages/1
  # GET /messages/1.json
  def show
	
  end

  # GET /messages/new
  def new
    #@message = Message.new 	
  end

  # GET /messages/1/edit
  def edit
  end

  # POST /messages
  # POST /messages.json
  def create
    @message = Message.new(message_params)
	@message.save
    respond_to do |format|
      if @message.save
        format.html { redirect_to @message, notice: 'Message was successfully created.' }
        format.json { render :show, status: :created, location: @message }
      else
        format.html { render :new }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /messages/1
  # PATCH/PUT /messages/1.json
  def update
    respond_to do |format|   
      if @message.update(message_params)
        format.html { redirect_to @message, notice: 'Message was successfully updated.' }
        format.json { render :show, status: :ok, location: @message }
      else
        format.html { render :edit }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /messages/1
  # DELETE /messages/1.json
  def destroy
    @message.destroy
    respond_to do |format|
      format.html { redirect_to messages_url, notice: 'Message was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
	def admin_report
		@message = Message.new
    end

	def admin
		@messages = Message.where(receiver: "Admin")
	end
  
	private
    # Use callbacks to share common setup or constraints between actions.
    def set_message
		@message= Message.find_by(params[:current_user])  
    	#@message = Message.find(params[:id])
  
	end
	
    # Never trust parameters from the scary internet, only allow the white list through.
    def message_params
      params.require(:message).permit(:sender, :receiver, :title, :body)
    end
=begin potrebbe servirmi dopo -A
	def adm_message_params
		list_params_allowed = [:sender, :receiver, :title, :body]
		list_params_allowed << :role if :receiver.is_admin?        
		params.require(:message).permit(list_params_allowed)
    end
=end
end
