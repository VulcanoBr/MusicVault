class CreateCassetteDetails < ActiveRecord::Migration[7.2]
  def change
    create_table :cassette_details do |t|
      t.references :media_physical, null: false, foreign_key: true
      t.references :cassette_type, null: false, foreign_key: true
      t.references :cassette_duration, null: false, foreign_key: true
      t.integer :disc_quantity, default: 1
      t.timestamps
    end

  end
end
