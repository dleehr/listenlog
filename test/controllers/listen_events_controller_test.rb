require 'test_helper'

class ListenEventsControllerTest < ActionController::TestCase
  setup do
    @listen_event = listen_events(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:listen_events)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create listen_event" do
    assert_difference('ListenEvent.count') do
      post :create, listen_event: { recording_id: @listen_event.recording_id, event_type: @listen_event.event_type}
    end

    assert_redirected_to listen_event_path(assigns(:listen_event))
  end

  test "should show listen_event" do
    get :show, id: @listen_event
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @listen_event
    assert_response :success
  end

  test "should update listen_event" do
    patch :update, id: @listen_event, listen_event: { recording_id: @listen_event.recording_id, event_type: @listen_event.event_type }
    assert_redirected_to listen_event_path(assigns(:listen_event))
  end

  test "should destroy listen_event" do
    assert_difference('ListenEvent.count', -1) do
      delete :destroy, id: @listen_event
    end

    assert_redirected_to listen_events_path
  end
end
