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
end
