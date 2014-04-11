class CreateListenEvents < ActiveRecord::Migration
  def change
    create_table :listen_events do |t|
      t.integer :event_type
      t.integer :recording_id

      t.timestamps
    end
  end
end
