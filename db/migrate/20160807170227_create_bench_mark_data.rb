class CreateBenchMarkData < ActiveRecord::Migration[5.0]
  def change
    create_table :bench_mark_data do |t|
      t.text :entries, array: true, default: []
      t.text :result
      t.jsonb :data
      t.timestamps
    end
  end
end
