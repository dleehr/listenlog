class AddActiveToRecording < ActiveRecord::Migration
  def change
    add_column :recordings, :active, :boolean, :default => false
  end
end
