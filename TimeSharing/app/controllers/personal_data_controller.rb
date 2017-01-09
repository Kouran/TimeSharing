class PersonalDataController < ApplicationController
	include SessionsHelper
  before_action :set_personal_datum, only: [:show, :edit, :update, :destroy]

  # GET /personal_data/1
  # GET /personal_data/1.json
  def show
	@user=User.find_by(id: @personal_datum.user_id)
  end

  # GET /personal_data/new
  def new
	if current_user==nil then redirect_to "/" end
	@userid=current_user
	if PersonalDatum.exists?(user_id: @userid) then redirect_to "/" end
    @personal_datum = PersonalDatum.new
  end

  # GET /personal_data/1/edit
  def edit
  end

  # POST /personal_data
  # POST /personal_data.json
  def create
    @personal_datum = PersonalDatum.new(personal_datum_params)

    respond_to do |format|
      if @personal_datum.save
        format.html { redirect_to @personal_datum, notice: 'Personal datum was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /personal_data/1
  # PATCH/PUT /personal_data/1.json
  def update
    respond_to do |format|
      if @personal_datum.update(personal_datum_params)
        format.html { redirect_to @personal_datum, notice: 'Personal datum was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
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
