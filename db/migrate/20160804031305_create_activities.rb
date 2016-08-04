class CreateActivities < ActiveRecord::Migration[5.0]
  def change
    create_table :activities do |t|
      t.string :title
      t.text :about
      t.integer :price
      t.integer :start_months_old
      t.integer :end_months_old
      t.boolean :camp
      t.boolean :drop_in
      t.boolean :date_night
      t.boolean :indoor
      t.boolean :outdoor
      t.timestamps
    end
  end
end
