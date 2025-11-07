class CreateGenres < ActiveRecord::Migration[7.2]
  def change
    create_table :genres do |t|
      t.string :name, null: false # Ex: 'Rock', 'Jazz', 'Pop'
      t.timestamps
    end
    add_index :genres, :name, unique: true
  end
end
