require 'test_helper'

class RecordingsControllerTest < ActionController::TestCase
  setup do
    @recording = recordings(:aud_la)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:recordings)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create recording" do
    assert_difference('Recording.count') do
      post :create, recording: { concert_id: @recording.concert_id, title: @recording.title }
    end

    assert_redirected_to recording_path(assigns(:recording))
  end

  test "should show recording" do
    get :show, id: @recording
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @recording
    assert_response :success
  end

  test "should update recording" do
    patch :update, id: @recording, recording: { concert_id: @recording.concert_id, title: @recording.title }
    assert_redirected_to recording_path(assigns(:recording))
  end

  test "should destroy recording" do
    assert_difference('Recording.count', -1) do
      delete :destroy, id: @recording
    end

    assert_redirected_to recordings_path
  end

  test "should start listening" do
    assert_difference('ListenEvent.count', 1) do
      post :start_listening, id: @recording
    end
    assert_redirected_to recording_path(assigns(:recording))
  end

  test "should finish listening" do
    assert_difference('ListenEvent.count', 1) do
      post :finish_listening, id: @recording
    end
    assert_redirected_to recording_path(assigns(:recording))
  end

  test "shows recordings in concert" do
    get :index, :concert => @recording.concert.id
    assert_response :success
    assert_not_nil assigns(:recordings)
    assert_includes assigns(:recordings), @recording
  end

  test "shows listening status and action" do
    get :show, id: @recording
    assert_not @recording.listening?
    assert_response :success
    assert_select 'div.actions' do
      assert_select '[value=?]', 'Start Listening'
    end
    assert_difference('ListenEvent.count', 1) do
      post :start_listening, id: @recording
    end
    assert_redirected_to recording_path(assigns(:recording))
    get :show, id: @recording
    assert @recording.listening?
    assert_response :success
    assert_select 'div.actions' do
      assert_select '[value=?]', 'Finish Listening'
    end
  end

end
