class WelcomeController < ApplicationController

  def home
			if not current_user.present?
				flash[:notice] = "You have to be logged for use the service"
			end
  end

	def contatti
	end

  #def result
      #parametro=params[:search]
      #@ads = Ad.where("title LIKE ? or category LIKE ? or description LIKE ? or applicant_user LIKE ?", "%#{parametro}%", "%#{parametro}%", "%#{parametro}%", "%#{parametro}%").order("created_at DESC")
 # end

end
