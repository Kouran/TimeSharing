require 'test_helper'

class AnnunciosControllerTest < ActionController::TestCase
  setup do
    @annuncio = annuncios(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:annuncios)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create annuncio" do
    assert_difference('Annuncio.count') do
      post :create, annuncio: { categoria: @annuncio.categoria, data: @annuncio.data, descrizione: @annuncio.descrizione, foto: @annuncio.foto, ore_previste: @annuncio.ore_previste, richiesta: @annuncio.richiesta, risolta: @annuncio.risolta, scadenza: @annuncio.scadenza, titolo: @annuncio.titolo, utente_adempiente: @annuncio.utente_adempiente, utente_richiedente: @annuncio.utente_richiedente, zona: @annuncio.zona }
    end

    assert_redirected_to annuncio_path(assigns(:annuncio))
  end

  test "should show annuncio" do
    get :show, id: @annuncio
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @annuncio
    assert_response :success
  end

  test "should update annuncio" do
    patch :update, id: @annuncio, annuncio: { categoria: @annuncio.categoria, data: @annuncio.data, descrizione: @annuncio.descrizione, foto: @annuncio.foto, ore_previste: @annuncio.ore_previste, richiesta: @annuncio.richiesta, risolta: @annuncio.risolta, scadenza: @annuncio.scadenza, titolo: @annuncio.titolo, utente_adempiente: @annuncio.utente_adempiente, utente_richiedente: @annuncio.utente_richiedente, zona: @annuncio.zona }
    assert_redirected_to annuncio_path(assigns(:annuncio))
  end

  test "should destroy annuncio" do
    assert_difference('Annuncio.count', -1) do
      delete :destroy, id: @annuncio
    end

    assert_redirected_to annuncios_path
  end
end
