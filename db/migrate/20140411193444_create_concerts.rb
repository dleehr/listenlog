class CreateConcerts < ActiveRecord::Migration
  def change
    create_table :concerts do |t|
      t.string :performer
      t.date :date

      t.timestamps
    end
  end
end
