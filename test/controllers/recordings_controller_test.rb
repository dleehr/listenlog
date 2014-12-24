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

  test "should pause listening" do
    @recording.start_listening # make sure listening before stop
    assert_difference('ListenEvent.count', 1) do
      post :pause_listening, id: @recording
    end
    assert_redirected_to recording_path(assigns(:recording))
  end

  test "should resume listening" do
    @recording.start_listening
    @recording.pause_listening # make sure paused before resume
    assert_difference('ListenEvent.count', 1) do
      post :resume_listening, id: @recording
    end
    assert_redirected_to recording_path(assigns(:recording))
  end

  test "should not resume active recording" do
    @recording.start_listening
    assert_difference('ListenEvent.count', 0) do
      post :resume_listening, id: @recording
    end
    assert_redirected_to recording_path(assigns(:recording))
  end

  test "should not pause non-started recording" do
    assert_difference('ListenEvent.count', 0) do
      post :pause_listening, id: @recording
    end
    assert_redirected_to recording_path(assigns(:recording))
  end


  test "should finish listening" do
    @recording.start_listening # make sure listening before stop
    assert_difference('ListenEvent.count', 1) do
      post :finish_listening, id: @recording
    end
    assert_redirected_to recording_path(assigns(:recording))
  end

  test "should finish listening with note" do
    @recording.start_listening # make sure listening before stop
    note = 'Done with this one'
    assert_difference('ListenEvent.count', 1) do
      post :finish_listening, id: @recording, note: note
    end
    assert_redirected_to recording_path(assigns(:recording))
    assert_equal note, assigns(:recording).last_event.note, 'event should have note'
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
    assert assigns(:recording).listening?, 'must be listening to expect finish button'
    assert_response :success
    assert_select 'div.actions' do
      assert_select '[value=?]', 'Finish Listening'
    end
  end

  test "shows listening recordings" do
    @recording.start_listening # make sure we're listening to something
    get :index, listening: true
    assert_response :success
    assert assigns(:recordings), 'should assign @recordings'
    assert_not_empty assigns(:recordings), 'must have one listening recording'
    assigns(:recordings).each do |recording|
      assert recording.listening?, 'requested listening recordings but found one not listening'
    end
  end

end
