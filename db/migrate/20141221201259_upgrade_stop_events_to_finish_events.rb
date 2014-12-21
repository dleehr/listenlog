class UpgradeStopEventsToFinishEvents < ActiveRecord::Migration
  def change
    Recording.all.each do |recording|
      last_event = recording.listen_events.last
      if last_event && last_event.is_stop?
        last_event.event_type = ListenEvent::FINISH
        last_event.save
      end
    end
  end
end
