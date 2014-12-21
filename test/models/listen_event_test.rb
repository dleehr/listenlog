require 'test_helper'

class ListenEventTest < ActiveSupport::TestCase
  test 'can create start event' do
    ev = ListenEvent.start_event
    assert ev.is_start?, 'event is not a start event'
    assert_not ev.is_stop?, 'event is a finish event'
    assert_nil ev.note, 'event should not have note'
  end

  test 'can create stop event' do
    ev = ListenEvent.stop_event
    assert ev.is_stop?, 'event is not a stop event'
    assert_not ev.is_start?, 'event is a start event'
    assert_nil ev.note, 'event should not have note'
  end

  test 'can get start events' do
    assert_not_empty ListenEvent.start_events
    ListenEvent.start_events.each do |event|
      assert event.is_start?, 'event in start_events scope is not a start'
    end
  end

  test 'can get stop events' do
    assert_not_empty ListenEvent.stop_events
    ListenEvent.stop_events.each do |event|
      assert event.is_stop?, 'event in start_events scope is not a start'
    end
  end

  test 'can get events by age' do
    assert_not_empty ListenEvent.by_age, 'Unable to get any events by age'
    assert ListenEvent.count >= 2, 'Need at least 2 events to compare by age'
    oldest = ListenEvent.by_age.first
    newest = ListenEvent.by_age.last
    assert oldest.created_at < newest.created_at, 'creation date of oldest event is not before creation date of newest'
  end

  test 'can create start event with note' do
    note = 'Some Song Name'
    ev = ListenEvent.start_event(note)
    assert ev.is_start?, 'event is not a start event'
    assert_not ev.is_stop?, 'event is a finish event'
    assert_equal(note, ev.note, 'event did not accept note')
  end

  test 'can create stop event with note' do
    note = 'Some Song Name 2'
    ev = ListenEvent.stop_event(note)
    assert ev.is_stop?, 'event is not a finish event'
    assert_not ev.is_start?, 'event is a start event'
    assert_equal(note, ev.note, 'event did not accept note')
  end

  test 'can get last listen event' do
    last = ListenEvent.last
    last_by_age = ListenEvent.by_age.last
    assert_equal(last, last_by_age, 'last mismatch')
  end

end
