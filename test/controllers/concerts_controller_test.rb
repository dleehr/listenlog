require 'test_helper'

class ConcertsControllerTest < ActionController::TestCase
  setup do
    @concert = concerts(:atlanta)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:concerts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create concert" do
    assert_difference('Concert.count') do
      post :create, concert: { date: @concert.date, performer: @concert.performer }
    end

    assert_redirected_to concert_path(assigns(:concert))
  end

  test "should show concert" do
    get :show, id: @concert
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @concert
    assert_response :success
  end

  test "should update concert" do
    patch :update, id: @concert, concert: { date: @concert.date, performer: @concert.performer }
    assert_redirected_to concert_path(assigns(:concert))
  end

  test "should destroy concert" do
    assert_difference('Concert.count', -1) do
      delete :destroy, id: @concert
    end

    assert_redirected_to concerts_path
  end

  test "should display recordings" do
    get :show, id: @concert
    assert_select 'li', @concert.recordings.first.title
  end

  test "should show years starting 1990 on new" do
    get :new
    assert_select 'select' do
      assert_select 'option', '1990'
    end
  end
end
