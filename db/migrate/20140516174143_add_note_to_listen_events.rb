class AddNoteToListenEvents < ActiveRecord::Migration
  def change
    add_column :listen_events, :note, :string
  end
end
