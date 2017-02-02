class AdministrationController < ApplicationController

	include SessionsHelper
	before_action :is_mod?, only: [:mod]
	before_action :is_admin?, only: [:admin]

	def admin
	end

	def mod
	end

	def unauthorized
	end
end
