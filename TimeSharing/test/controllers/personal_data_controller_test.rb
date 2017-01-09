require 'test_helper'

class PersonalDataControllerTest < ActionController::TestCase
  setup do
    @personal_datum = personal_data(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:personal_data)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create personal_datum" do
    assert_difference('PersonalDatum.count') do
      post :create, personal_datum: { actual_job: @personal_datum.actual_job, city: @personal_datum.city, date_of_birth: @personal_datum.date_of_birth, name: @personal_datum.name, phone: @personal_datum.phone, skills: @personal_datum.skills, surname: @personal_datum.surname }
    end

    assert_redirected_to personal_datum_path(assigns(:personal_datum))
  end

  test "should show personal_datum" do
    get :show, id: @personal_datum
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @personal_datum
    assert_response :success
  end

  test "should update personal_datum" do
    patch :update, id: @personal_datum, personal_datum: { actual_job: @personal_datum.actual_job, city: @personal_datum.city, date_of_birth: @personal_datum.date_of_birth, name: @personal_datum.name, phone: @personal_datum.phone, skills: @personal_datum.skills, surname: @personal_datum.surname }
    assert_redirected_to personal_datum_path(assigns(:personal_datum))
  end

  test "should destroy personal_datum" do
    assert_difference('PersonalDatum.count', -1) do
      delete :destroy, id: @personal_datum
    end

    assert_redirected_to personal_data_path
  end
end
