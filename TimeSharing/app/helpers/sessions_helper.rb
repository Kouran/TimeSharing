module SessionsHelper
	#Log in	
	def log_in(user)
		session[:user_id]=user.id
	end

	#Current user
	def current_user
		@current_user || User.find_by(id: session[:user_id])
	end

	#Logged in boolean function
	def logged_in?
		!current_user?
	end

	#Log out
	def log_out
		session.delete(:user_id)
		@current_user=nil
	end

end
