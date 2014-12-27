require 'test_helper'

class RecordingTest < ActiveSupport::TestCase
  test 'can start listening' do
    r = Recording.create(:title => 'Test Recording')
    assert r.start_listening, 'could not start listening'
  end

  test 'can pause listening' do
    r = Recording.create(:title => 'Test pause Recording')
    assert r.start_listening, 'Could not start listening'
    assert r.listening?, 'should be listening'
    assert r.pause_listening, 'Could not pause listening'
  end

  test 'can finish listening after starting' do
    r = Recording.create(:title => 'Test Recording2')
    assert r.start_listening, 'could not start listening'
    assert r.listening?, 'should be listening?'
    assert r.finish_listening, 'could not stop listening'
    assert_not r.listening?, 'should not be listening?'
  end

  test 'can resume listening' do
    r = Recording.create(:title => 'Test pause Recording')
    assert r.start_listening, 'Could not start listening'
    assert r.listening?, 'should be listening'
    assert r.pause_listening, 'Could not pause listening'
    assert_not r.listening?, 'should not be listening'
    assert r.resume_listening, 'could not resume'
    assert r.listening?, 'should be listening'
  end

  test 'cannot save without title' do
    r = Recording.new
    assert_not r.save, 'should not save without a file'
  end

  test 'can get listening recordings' do
    listening_count = Recording.listening.count
    not_listening_count = Recording.not_listening.count
    total_count = Recording.count
    assert_equal total_count, listening_count + not_listening_count, 'listening + not listening should equal total'
    assert_equal Recording.listening, Recording.by_listening(true), 'listening should equal by_listening(true)'
  end

  test 'can active recording' do
    r = Recording.create(title: 'to test active')
    assert_difference('Recording.active.count') do
      r.start_listening
    end
  end

  test 'can deactivate recording' do
    r = Recording.create(title: 'to test deactive')
    r.start_listening
    assert_difference('Recording.active.count', -1) do
      r.finish_listening
    end
  end

end
