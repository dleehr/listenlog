class CreateRecordings < ActiveRecord::Migration
  def change
    create_table :recordings do |t|
      t.string :title
      t.integer :concert_id

      t.timestamps
    end
  end
end
