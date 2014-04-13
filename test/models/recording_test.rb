require 'test_helper'

class RecordingTest < ActiveSupport::TestCase
  test 'can start listening' do
    r = Recording.create(:title => 'Test Recording')
    assert r.start_listening, 'could not start listening'
  end
  test 'can finish listening after starting' do
    r = Recording.create(:title => 'Test Recording2')
    assert r.start_listening, 'could not start listening'
    assert r.listening?, 'should be listening?'
    assert r.finish_listening, 'could not stop listening'
    assert_not r.listening?, 'should not be listening?'
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
  end
end
