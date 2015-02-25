require 'test_helper'

class ListenEventsControllerTest < ActionController::TestCase
  include Devise::TestHelpers
  setup do
    sign_in(User.first)
    @listen_event = listen_events(:one)
    @recording = @listen_event.recording
  end

  teardown do
    @listen_event = nil
    @recording = nil
    sign_out(User.first)
  end

  test "should get index" do
    get :index, recording_id: @recording.id
    assert_response :success
    assert_not_nil assigns(:listen_events)
  end

  test "should get new" do
    get :new, recording_id: @recording.id
    assert_response :success
  end

  test "should create listen_event" do
    assert_difference('ListenEvent.count') do
      post :create, listen_event: { event_type: @listen_event.event_type, note: 'note here'}, recording_id: @recording.id
    end
    assert_redirected_to recording_listen_event_path(assigns(:recording), assigns(:listen_event))
  end

  test "should show listen_event" do
    get :show, id: @listen_event, recording_id: @recording.id
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @listen_event, recording_id: @recording.id
    assert_response :success
  end

  test "should update listen_event" do
    patch :update, id: @listen_event, recording_id: @recording.id, listen_event: { recording_id: @listen_event.recording_id, event_type: @listen_event.event_type }
    assert_redirected_to recording_listen_event_path(assigns(:recording), assigns(:listen_event))
  end

  test "should destroy listen_event" do
    assert_difference('ListenEvent.count', -1) do
      delete :destroy, {id: @listen_event, recording_id: @recording.id}
    end

    assert_redirected_to recording_listen_events_path(assigns(:recording))
  end

  test "shows listen events in recording" do
    get :index, :recording_id => @listen_event.recording.id
    assert_response :success
    assert_not_nil assigns(:listen_events)
    assert_includes assigns(:listen_events), @listen_event
  end

  test "shows last event" do
    get :last, recording_id: @recording.id
    assert_response :success
    assert_not_nil assigns(:listen_event)
  end

end
