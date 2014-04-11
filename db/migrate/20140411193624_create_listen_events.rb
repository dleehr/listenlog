class CreateListenEvents < ActiveRecord::Migration
  def change
    create_table :listen_events do |t|
      t.integer :type
      t.integer :recording_id

      t.timestamps
    end
  end
end
