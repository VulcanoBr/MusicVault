class CreateCassetteTypes < ActiveRecord::Migration[7.2]
  def change
    create_table :cassette_types do |t|
      t.string :name, null: false # Ex: 'Normal', 'CrO2', 'Metal'
      t.timestamps
    end
    add_index :cassette_types, :name, unique: true
  end
end
