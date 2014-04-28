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

  test 'can get events by age' do
    assert_not_empty ListenEvent.by_age, 'Unable to get any events by age'
    assert ListenEvent.count >= 2, 'Need at least 2 events to compare by age'
    oldest = ListenEvent.by_age.first
    newest = ListenEvent.by_age.last
    assert oldest.created_at < newest.created_at, 'creation date of oldest event is not before creation date of newest'
  end
end
