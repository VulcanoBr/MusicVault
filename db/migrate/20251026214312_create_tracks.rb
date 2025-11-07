class CreateTracks < ActiveRecord::Migration[7.2]
  def change
    create_table :tracks do |t|
      t.references :media_physical, null: false, foreign_key: true
      t.integer :track_number, null: false
      t.integer :disc_number, default: 1 # Usado para álbuns com múltiplos discos
      t.string :side # Usado para Vinil e Cassete. Ex: 'A', 'B'
      t.string :track_title, null: false
      t.string :track_artist_name # intérprete da faixa
      t.string :composer
      t.string :featured_artist
      t.string :duration # Ex: '03:45' (armazenar como string é mais flexível)
      t.string :isrc
      t.text :track_notes
      t.timestamps
    end
    add_index :tracks, [:media_physical_id, :disc_number, :side, :track_number], name: 'index_tracks_on_media_physical_order'
  end
end
