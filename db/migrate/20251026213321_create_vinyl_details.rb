class CreateVinylDetails < ActiveRecord::Migration[7.2]
  def change
    create_table :vinyl_details do |t|
      t.references :media_physical, null: false, foreign_key: true
      t.integer :disc_quantity, default: 1
      t.string :size # Ex: '12"', '10"', '7"'
      t.string :speed # Ex: '33 RPM', '45 RPM'
      t.string :color # Ex: 'Black', 'Colored', 'Picture Disc'
      t.string :edition # Ex: 'Original', 'Reissue', 'Limited'
      t.string :matrix_number
      t.timestamps
    end

  end
end
