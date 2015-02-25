class ActivateExistingRecordings < ActiveRecord::Migration
  def up
    Recording.all.each do |r|
      if r.last_event && r.last_event.event_type != ListenEvent::FINISH
        r.active = true
        r.save
      end
    end
  end
  def down
    Recording.all.each do |r|
      r.active = false
      r.save
    end
  end
end
