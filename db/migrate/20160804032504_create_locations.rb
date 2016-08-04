class CreateLocations < ActiveRecord::Migration[5.0]
  def change
    create_table :locations do |t|
      t.string :name
      t.string :line1
      t.string :city
      t.timestamps
    end
  end
end
