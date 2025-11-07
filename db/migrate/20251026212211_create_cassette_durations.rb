class CreateCassetteDurations < ActiveRecord::Migration[7.2]
  def change
    create_table :cassette_durations do |t|
      t.string :name, null: false # Ex: 'C60', 'C90', 'C120'
      t.timestamps
    end
    add_index :cassette_durations, :name, unique: true
  end
end
