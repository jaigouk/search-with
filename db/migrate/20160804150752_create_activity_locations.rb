class CreateActivityLocations < ActiveRecord::Migration[5.0]
  def change
    create_table :activity_locations do |t|
      t.belongs_to :activity
      t.belongs_to :location
      t.timestamps
    end
  end
end
