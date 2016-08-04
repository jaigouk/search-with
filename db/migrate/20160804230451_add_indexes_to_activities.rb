class AddIndexesToActivities < ActiveRecord::Migration[5.0]
  def up
    add_index :activities, :start_months_old
    add_index :activities, :end_months_old
    add_index :activities, :camp
    add_index :activities, :drop_in
    add_index :activities, :date_night
    add_index :activities, :indoor
    add_index :activities, :outdoor
  end

  def down
    remove_index :activities, :start_months_old
    remove_index :activities, :end_months_old
    remove_index :activities, :camp
    remove_index :activities, :drop_in
    remove_index :activities, :date_night
    remove_index :activities, :indoor
    remove_index :activities, :outdoor
  end
end
