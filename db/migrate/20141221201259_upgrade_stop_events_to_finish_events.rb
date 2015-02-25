class UpgradeStopEventsToFinishEvents < ActiveRecord::Migration
  def up
    Recording.all.each do |recording|
      last_event = recording.listen_events.last
      if last_event && last_event.is_pause?
        last_event.event_type = ListenEvent::FINISH
        last_event.save
      end
    end
  end
  def down
    Recording.all.each do |recording|
      last_event = recording.listen_events.last
      if last_event && last_event.is_finish?
        last_event.event_type = ListenEvent::STOP
        last_event.save
      end
    end
  end
end
