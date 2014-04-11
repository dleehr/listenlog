require 'test_helper'

class RecordingTest < ActiveSupport::TestCase
  test 'can start listening' do
    r = Recording.create(:title => 'Test Recording')
    assert r.start_listening, 'could not start listening'
  end
  test 'can finish listening after starting' do
    r = Recording.create(:title => 'Test Recording2')
    assert r.start_listening, 'could not start listening'
    assert r.finish_listening, 'could not stop listening'
  end
end
