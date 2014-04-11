require 'test_helper'

class ListenEventTest < ActiveSupport::TestCase
  test 'can create start event' do
    ev = ListenEvent.start_event
    assert ev.is_start?, 'event is not a start event'
    assert_not ev.is_finish?, 'event is a finish event'
  end

  test 'can create finish event' do
    ev = ListenEvent.finish_event
    assert ev.is_finish?, 'event is not a finish event'
    assert_not ev.is_start?, 'event is a start event'
  end
end
