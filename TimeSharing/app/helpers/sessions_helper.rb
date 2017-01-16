module SessionsHelper
	#Log in	
	def log_in(user)
		session[:user_id]=user.id
	end

	#Current user
	def current_user
		User.find_by(id: session[:user_id])
	end
	
	

	#Logged in boolean function
	def logged_in?
		current_user.present?
	end

	#Log out
	def log_out
		session.delete(:user_id)
		@current_user=nil
	end

	def check_auth(level=0)
		#controlla che l'utente sia loggato
		if not logged_in? then redirect_to "/notlogged" and return end
		#controlla che l'utente abbia "confermato" la sua registrazione
		@userid=current_user
		if not UserPlatformDatum.exists?(user_id: @userid) then redirect_to "/user_platform_data/new" and return end
		#controlla che l'utente abbia i permessi necessari
		@userpermission=UserPlatformDatum.find_by(id: @userid).access
		if not @userpermission>=level then redirect_to "/unauthorized" end
	end

end
