class PersonalDataController < ApplicationController
	include SessionsHelper
	before_action :set_personal_datum, only: [:show, :edit, :update, :destroy]
	before_action :logged_in?

  # GET /personal_data/1
  def show
	@user=User.find_by(id: @personal_datum.user_id)
  end

  # GET /personal_data/new
  def new
	if current_user==nil then redirect_to "/unauthorized" and return end
	@userid=current_user.id
	if PersonalDatum.exists?(user_id: @userid)
		@plat=PersonalDatum.find_by(user_id: @userid).id
		redirect_to "/personal_data/#{@plat}/edit" 
		return 
	end
    @personal_datum = PersonalDatum.new
  end

  # GET /personal_data/1/edit
  def edit
	if not (current_user==@personal_datum.user or check_auth(3)) then redirect_to "/unauthorized" and return end
  end

  # POST /personal_data
  def create
	if @personal=PersonalDatum.find_by(user_id: params[:personal_datum][:user_id]) then redirect_to @personal and return end
	@personal_datum = PersonalDatum.new(personal_datum_params)
	@personal_datum.user=current_user
	if @personal_datum.save
		redirect_to @personal_datum
	else
		render :new
	end
  end

  # PUT /personal_data/1
  def update
	if not (current_user==@personal_datum.user or check_auth(3)) then redirect_to "/unauthorized" and return end
	if @personal_datum.update(personal_datum_params)
		redirect_to @personal_datum
 	else
		render :edit
	end
  end
  
	def destroy
		if not (current_user==@personal_datum.user or check_auth(3)) then redirect_to "/unauthorized" and return end
		@user=@personal_datum.user
		@personal_datum.destroy
		redirect_to @user
	end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_personal_datum
      @personal_datum = PersonalDatum.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def personal_datum_params
      params.require(:personal_datum).permit(:user_id, :name, :surname, :date_of_birth, :city, :actual_job, :phone, :skills)
    end
end
