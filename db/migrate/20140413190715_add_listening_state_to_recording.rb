class AddListeningStateToRecording < ActiveRecord::Migration
  def change
    add_column :recordings, 'listening', :boolean, {default: false, null: false}
    Recording.all.each do |recording|
      if recording.listen_events.empty? || recording.listen_events.last.is_stop?
        recording.listening = false
      else
        recording.listening = true
      end
      recording.save
    end
  end
end
