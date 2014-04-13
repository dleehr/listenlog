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

  test 'can get start events' do
    assert_not_empty ListenEvent.start_events
    ListenEvent.start_events.each do |event|
      assert event.is_start?, 'event in start_events scope is not a start'
    end
  end

  test 'can get finish events' do
    assert_not_empty ListenEvent.finish_events
    ListenEvent.finish_events.each do |event|
      assert event.is_finish?, 'event in start_events scope is not a start'
    end
  end

end
