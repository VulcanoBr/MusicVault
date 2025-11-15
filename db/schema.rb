# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.2].define(version: 2025_10_31_005436) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "blu_ray_details", force: :cascade do |t|
    t.bigint "media_physical_id", null: false
    t.integer "disc_quantity", default: 1
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["media_physical_id"], name: "index_blu_ray_details_on_media_physical_id"
  end

  create_table "cassette_details", force: :cascade do |t|
    t.bigint "media_physical_id", null: false
    t.bigint "cassette_type_id", null: false
    t.bigint "cassette_duration_id", null: false
    t.integer "disc_quantity", default: 1
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cassette_duration_id"], name: "index_cassette_details_on_cassette_duration_id"
    t.index ["cassette_type_id"], name: "index_cassette_details_on_cassette_type_id"
    t.index ["media_physical_id"], name: "index_cassette_details_on_media_physical_id"
  end

  create_table "cassette_durations", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_cassette_durations_on_name", unique: true
  end

  create_table "cassette_types", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_cassette_types_on_name", unique: true
  end

  create_table "cd_details", force: :cascade do |t|
    t.bigint "media_physical_id", null: false
    t.integer "disc_quantity", default: 1
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["media_physical_id"], name: "index_cd_details_on_media_physical_id"
  end

  create_table "countries", force: :cascade do |t|
    t.string "name", null: false
    t.string "code", null: false
    t.string "flag_code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["code"], name: "index_countries_on_code", unique: true
  end

  create_table "dvd_details", force: :cascade do |t|
    t.bigint "media_physical_id", null: false
    t.integer "disc_quantity", default: 1
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["media_physical_id"], name: "index_dvd_details_on_media_physical_id"
  end

  create_table "genres", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_genres_on_name", unique: true
  end

  create_table "imprints", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_imprints_on_name", unique: true
  end

  create_table "media_physicals", force: :cascade do |t|
    t.bigint "media_type_id", null: false
    t.string "album_title", null: false
    t.string "artist_band", null: false
    t.bigint "record_label_id", null: false
    t.bigint "imprint_id"
    t.bigint "genre_id", null: false
    t.bigint "country_id", null: false
    t.integer "release_year"
    t.bigint "release_type_id", null: false
    t.string "barcode"
    t.string "label_code"
    t.text "general_notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["album_title"], name: "index_media_physicals_on_album_title"
    t.index ["artist_band"], name: "index_media_physicals_on_artist_band"
    t.index ["country_id"], name: "index_media_physicals_on_country_id"
    t.index ["genre_id"], name: "index_media_physicals_on_genre_id"
    t.index ["imprint_id"], name: "index_media_physicals_on_imprint_id"
    t.index ["media_type_id"], name: "index_media_physicals_on_media_type_id"
    t.index ["record_label_id"], name: "index_media_physicals_on_record_label_id"
    t.index ["release_type_id"], name: "index_media_physicals_on_release_type_id"
    t.index ["release_year"], name: "index_media_physicals_on_release_year"
  end

  create_table "media_types", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_media_types_on_name", unique: true
  end

  create_table "record_labels", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_record_labels_on_name", unique: true
  end

  create_table "release_types", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_release_types_on_name", unique: true
  end

  create_table "tracks", force: :cascade do |t|
    t.bigint "media_physical_id", null: false
    t.integer "track_number", null: false
    t.integer "disc_number", default: 1
    t.string "side"
    t.string "track_title", null: false
    t.string "track_artist_name"
    t.string "composer"
    t.string "featured_artist"
    t.string "duration"
    t.string "isrc"
    t.text "track_notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["media_physical_id", "disc_number", "side", "track_number"], name: "index_tracks_on_media_physical_order"
    t.index ["media_physical_id"], name: "index_tracks_on_media_physical_id"
  end

  create_table "vinyl_details", force: :cascade do |t|
    t.bigint "media_physical_id", null: false
    t.integer "disc_quantity", default: 1
    t.string "size"
    t.string "speed"
    t.string "color"
    t.string "edition"
    t.string "matrix_number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["media_physical_id"], name: "index_vinyl_details_on_media_physical_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "blu_ray_details", "media_physicals"
  add_foreign_key "cassette_details", "cassette_durations"
  add_foreign_key "cassette_details", "cassette_types"
  add_foreign_key "cassette_details", "media_physicals"
  add_foreign_key "cd_details", "media_physicals"
  add_foreign_key "dvd_details", "media_physicals"
  add_foreign_key "media_physicals", "countries"
  add_foreign_key "media_physicals", "genres"
  add_foreign_key "media_physicals", "imprints"
  add_foreign_key "media_physicals", "media_types"
  add_foreign_key "media_physicals", "record_labels"
  add_foreign_key "media_physicals", "release_types"
  add_foreign_key "tracks", "media_physicals"
  add_foreign_key "vinyl_details", "media_physicals"
end
