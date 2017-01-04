class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
	include SessionsHelper
	
	helper_method :mailbox
	helper_method :conversations
	helper_method :current_user

	def conversation 
		@conversation ||= Mailbox.conversations.find(current_user)
	end
	
	def current_user 
		return unless session[:user_id]
		@current_user =User.find(session[:user_id])
	end

	private
	def mailbox 
		@mailbox ||= current_user.mailbox	
	end 
	protected
end
