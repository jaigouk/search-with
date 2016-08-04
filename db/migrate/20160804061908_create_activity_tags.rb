class CreateActivityTags < ActiveRecord::Migration[5.0]
  def change
    create_table :activity_tags do |t|
      t.belongs_to :activity
      t.belongs_to :tag
      t.timestamps
    end
  end
end
