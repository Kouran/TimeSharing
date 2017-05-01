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
		if not current_user.present? then redirect_to "/unauthorized" and return false
		end
		return true
	end

	#Log out
	def log_out
		session.delete(:user_id)
		@current_user=nil
	end

	def check_auth(level=0)
		#controlla che l'utente sia loggato
		unless current_user.present? then
			return false
		end
		userid=current_user
		#controlla che l'utente abbia i permessi necessari
		userpermission=UserPlatformDatum.find_by(user: userid).access
		unless userpermission>=level then
			return false
		end
		return true
	end

	# controlla se è amministratore
	def is_admin?
		unless check_auth(3) then redirect_to "/unauthorized" and return false end
		return true
	end

	def is_mod?
		unless check_auth(2) then redirect_to "/unauthorized" and return false end
		return true
	end

end
