class UpgradeStartEventsToResumeEvents < ActiveRecord::Migration
  def up
    Recording.all.each do |recording|
      first_event = recording.listen_events.first
      recording.listen_events.start_events.each_with_index do |event, index|
        if index > 0
          event.event_type = ListenEvent::RESUME
          event.save
        end
      end
    end
  end
  def down
    ListenEvent.resume_events.each do |event|
      event.event_type = ListenEvent::START
      event.save
    end
  end
end
