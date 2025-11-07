class CreateReleaseTypes < ActiveRecord::Migration[7.2]
  def change
    create_table :release_types do |t|
      t.string :name, null: false # Ex: 'Studio Album', 'Live', 'Compilation'
      t.timestamps
    end
    add_index :release_types, :name, unique: true
  end
end
