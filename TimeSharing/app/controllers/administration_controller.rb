class AdministrationController < ApplicationController

	include SessionsHelper

	def admin
		if not check_auth(3) then redirect_to "/unauthorized" and return end
	end

	def mod
		if not check_auth(2) then redirect_to "/unauthorized" and return end
	end

	def unauthorized
	end
end
