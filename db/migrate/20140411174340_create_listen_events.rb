class CreateListenEvents < ActiveRecord::Migration
  def change
    create_table :listen_events do |t|
      t.string :title
      t.date :started
      t.date :finished
      t.string :equipment

      t.timestamps
    end
  end
end
