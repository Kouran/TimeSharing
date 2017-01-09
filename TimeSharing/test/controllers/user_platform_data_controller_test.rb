require 'test_helper'

class UserPlatformDataControllerTest < ActionController::TestCase
  setup do
    @user_platform_datum = user_platform_data(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:user_platform_data)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create user_platform_datum" do
    assert_difference('UserPlatformDatum.count') do
      post :create, user_platform_datum: { access: @user_platform_datum.access, applying_rating: @user_platform_datum.applying_rating, fullfilling_rating: @user_platform_datum.fullfilling_rating, total_rating: @user_platform_datum.total_rating, user_id: @user_platform_datum.user_id, wallet: @user_platform_datum.wallet }
    end

    assert_redirected_to user_platform_datum_path(assigns(:user_platform_datum))
  end

  test "should show user_platform_datum" do
    get :show, id: @user_platform_datum
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @user_platform_datum
    assert_response :success
  end

  test "should update user_platform_datum" do
    patch :update, id: @user_platform_datum, user_platform_datum: { access: @user_platform_datum.access, applying_rating: @user_platform_datum.applying_rating, fullfilling_rating: @user_platform_datum.fullfilling_rating, total_rating: @user_platform_datum.total_rating, user_id: @user_platform_datum.user_id, wallet: @user_platform_datum.wallet }
    assert_redirected_to user_platform_datum_path(assigns(:user_platform_datum))
  end

  test "should destroy user_platform_datum" do
    assert_difference('UserPlatformDatum.count', -1) do
      delete :destroy, id: @user_platform_datum
    end

    assert_redirected_to user_platform_data_path
  end
end
