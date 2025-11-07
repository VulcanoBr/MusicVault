class CreateMediaTypes < ActiveRecord::Migration[7.2]
  def change
    create_table :media_types do |t|
      t.string :name, null: false # Ex: 'Vinyl', 'CD', 'DVD', 'Cassette'
      t.timestamps
    end
    add_index :media_types, :name, unique: true
  end
end
