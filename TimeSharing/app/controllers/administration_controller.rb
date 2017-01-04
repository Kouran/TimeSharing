class AdministrationController < ApplicationController

	include SessionsHelper

	def admin
		check_auth(3)
	end

	def mod
		check_auth(2)
	end


	def notlogged
	end

	def unauthorized
	end
end
