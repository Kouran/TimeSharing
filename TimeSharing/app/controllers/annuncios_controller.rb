class AnnunciosController < ApplicationController
  before_action :set_annuncio, only: [:show, :edit, :update, :destroy]

  # GET /annuncios
  # GET /annuncios.json
  def index
    @annuncios = Annuncio.all
  end

  # GET /annuncios/1
  # GET /annuncios/1.json
  def show
  end

  # GET /annuncios/new
  def new
    @annuncio = Annuncio.new
  end

  # GET /annuncios/1/edit
  def edit
  end

  # POST /annuncios
  # POST /annuncios.json
  def create
    @annuncio = Annuncio.new(annuncio_params)

    respond_to do |format|
      if @annuncio.save
        format.html { redirect_to @annuncio, notice: 'Annuncio was successfully created.' }
        format.json { render :show, status: :created, location: @annuncio }
      else
        format.html { render :new }
        format.json { render json: @annuncio.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /annuncios/1
  # PATCH/PUT /annuncios/1.json
  def update
    respond_to do |format|
      if @annuncio.update(annuncio_params)
        format.html { redirect_to @annuncio, notice: 'Annuncio was successfully updated.' }
        format.json { render :show, status: :ok, location: @annuncio }
      else
        format.html { render :edit }
        format.json { render json: @annuncio.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /annuncios/1
  # DELETE /annuncios/1.json
  def destroy
    @annuncio.destroy
    respond_to do |format|
      format.html { redirect_to annuncios_url, notice: 'Annuncio was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_annuncio
      @annuncio = Annuncio.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def annuncio_params
      params.require(:annuncio).permit(:titolo, :categoria, :descrizione, :zona, :ore_previste, :scadenza, :data, :foto, :richiesta, :risolta, :utente_richiedente, :utente_adempiente)
    end
end
