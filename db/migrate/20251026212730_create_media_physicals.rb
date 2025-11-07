class CreateMediaPhysicals < ActiveRecord::Migration[7.2]
  def change
    create_table :media_physicals do |t|
      t.references :media_type, null: false, foreign_key: true
      t.string :album_title, null: false
      t.string :artist_band, null: false
      t.references :record_label, null: false, foreign_key: true
      t.references :imprint, foreign_key: true
      t.references :genre, null: false, foreign_key: true
      t.references :country, null: false, foreign_key: true
      t.integer :release_year
      t.references :release_type, null: false, foreign_key: true
      t.string :barcode
      t.string :label_code
      t.text :general_notes
      t.timestamps
    end
    add_index :media_physicals, :album_title
    add_index :media_physicals, :artist_band
    add_index :media_physicals, :release_year
  end
end
