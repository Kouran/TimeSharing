require 'test_helper'

class UtentesControllerTest < ActionController::TestCase
  setup do
    @utente = utentes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:utentes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create utente" do
    assert_difference('Utente.count') do
      post :create, utente: { citta_residenza: @utente.citta_residenza, cognome: @utente.cognome, competenze: @utente.competenze, data_nascita: @utente.data_nascita, email: @utente.email, nickname: @utente.nickname, nome: @utente.nome, portafoglio: @utente.portafoglio, professione: @utente.professione, telefono: @utente.telefono }
    end

    assert_redirected_to utente_path(assigns(:utente))
  end

  test "should show utente" do
    get :show, id: @utente
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @utente
    assert_response :success
  end

  test "should update utente" do
    patch :update, id: @utente, utente: { citta_residenza: @utente.citta_residenza, cognome: @utente.cognome, competenze: @utente.competenze, data_nascita: @utente.data_nascita, email: @utente.email, nickname: @utente.nickname, nome: @utente.nome, portafoglio: @utente.portafoglio, professione: @utente.professione, telefono: @utente.telefono }
    assert_redirected_to utente_path(assigns(:utente))
  end

  test "should destroy utente" do
    assert_difference('Utente.count', -1) do
      delete :destroy, id: @utente
    end

    assert_redirected_to utentes_path
  end
end
