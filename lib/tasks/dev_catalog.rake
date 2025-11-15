# frozen_string_literal: true
require 'faker'
namespace :dev_catalog do
  desc "Populates support tables for the media catalog development environment"
  task seed: :environment do
    puts "Starting to seed support tables..."

    # Verifica se a tabela básica existe antes de tentar popular
    unless ActiveRecord::Base.connection.table_exists?('media_types')
      puts "Error: 'media_types' table not found. Please run 'rails db:migrate' first."
      exit
    end

    # -------------------------------------------------
    # 1. Tipos de Mídia (Media Types)
    # -------------------------------------------------
    puts "Seeding Media Types..."
    MediaType.destroy_all
    MediaType.create!([{ name: 'Vinyl' }, { name: 'CD' }, { name: 'DVD' }, { name: 'Cassette Tape' }, { name: 'Blu-Ray' }])
    puts "#{MediaType.count} media types created."

    # -------------------------------------------------
    # 2. Tipos de Lançamento (Release Types)
    # -------------------------------------------------
    puts "Seeding Release Types..."
    ReleaseType.destroy_all
    release_types = [
      'Studio Album', 'Live Album', 'Compilation', 'Single', 'EP',
      'Soundtrack', 'Demo', 'Remix Album', 'Box Set', 'Interview', 'Collection'
    ]

    release_types.each { |name| ReleaseType.create!(name: name) }
    puts "#{ReleaseType.count} release types created."

    # -------------------------------------------------
    # 3. Tipos de Fita Cassete (Cassette Types)
    # -------------------------------------------------
    puts "Seeding Cassette Types..."
    CassetteType.destroy_all
    cassette_types = ['Normal (Type I)', 'CrO2 (Type II)', 'Metal (Type IV)']
    cassette_types.each { |name| CassetteType.create!(name: name) }
    puts "#{CassetteType.count} cassette types created."

    # -------------------------------------------------
    # 4. Durações de Fita Cassete (Cassette Durations)
    # -------------------------------------------------
    puts "Seeding Cassette Durations..."
    CassetteDuration.destroy_all
    cassette_durations = ['C30', 'C46', 'C60', 'C90', 'C100', 'C120']
    cassette_durations.each { |name| CassetteDuration.create!(name: name) }
    puts "#{CassetteDuration.count} cassette durations created."

    # -------------------------------------------------
    # 5. Gêneros Musicais (Genres) - Mais de 30
    # -------------------------------------------------
    puts "Seeding Genres..."
    Genre.destroy_all
    genres = [
      'Rock', 'Pop', 'Jazz', 'Blues', 'Classical', 'Hip Hop', 'Electronic',
      'Country', 'Folk', 'Soul', 'Funk', 'Reggae', 'Punk', 'Metal',
      'Alternative', 'Indie', 'R&B', 'Disco', 'Techno', 'House', 'Ambient',
      'Gospel', 'Latin', 'Ska', 'Progressive Rock', 'Psychedelic Rock',
      'New Wave', 'Synth-pop', 'Hardcore Punk', 'Grunge', 'Shoegaze',
      'Post-Rock', 'Experimental', 'Dub', 'Trip Hop', 'Drum & Bass',
      'Trance', 'Industrial', 'Gothic Rock', 'Samba', 'Bossa Nova', 'MPB',
      'Pagode', 'Samba Enredo', 'Sertanejo', 'Eletrofunk', 'Dubstep',  'Gótico',
      'Hard Rock', 'Forró', 'Axé', 'Trap', 'K-Pop', 'J-Pop', 'New Age',
      'World Music', 'Latin Jazz', 'Bebop', 'Smooth Jazz'
    ]
    genres.each { |name| Genre.create!(name: name) }
    puts "#{Genre.count} genres created."

    # -------------------------------------------------
    # 6. Gravadoras (Record Labels) - Mais de 30
    # -------------------------------------------------
    puts "Seeding Record Labels..."
    RecordLabel.destroy_all
    labels = [
      'Universal Music Group', 'Sony Music Entertainment', 'Warner Music Group',
      'Atlantic Records', 'Capitol Records', 'Elektra Records', 'Island Records',
      'Motown', 'RCA Records', 'Columbia Records', 'Epic Records', 'Def Jam Recordings',
      'Sub Pop', 'Matador Records', 'Domino Recording Company', '4AD', 'XL Recordings',
      'Ninja Tune', 'Warp Records', 'Ghostly International', 'Brainfeeder',
      'Stone Throw', 'Fool\'s Gold Records', 'Young', 'Secretly Canadian',
      'Jagjaguwar', 'Dead Oceans', 'Merge Records', 'Drag City', 'Epitaph Records',
      'Fat Possum', 'Polydor', 'Parlophone', 'Blue Note Records', 'Impulse! Records',
      'Rough Trade Records', 'Beggars Group', 'SomLivre'
    ]
    labels.each { |name| RecordLabel.create!(name: name) }
    puts "#{RecordLabel.count} record labels created."

    # -------------------------------------------------
    # 7. Selos (Imprints) - Mais de 30
    # -------------------------------------------------
    puts "Seeding Imprints..."
    Imprint.destroy_all
    imprints = [
      'Capitol', 'Virgin', 'EMI', 'Atlantic Records', 'Reprise', 'Geffen', 'Interscope',
      'A&M', 'Island', 'Def Jam', 'Columbia', 'RCA Victor', 'Epic', 'Legacy',
      'Motown', 'Tamla', 'Gordy', 'Soul', 'Blue Note', 'Impulse!', 'Verve',
      'Warner Bros.', 'Sire', 'London', 'Deram', 'Harvest', 'Parlophone',
      'Apple', 'Factory', 'Creation', 'Rough Trade', '4AD', 'Beggars Banquet',
      'XL', 'Young', 'Domino', 'Sub Pop', 'Matador', 'Merge', 'Touch and Go', 'Arista'
    ]
    imprints.each { |name| Imprint.create!(name: name) }
    puts "#{Imprint.count} imprints created."

    # -------------------------------------------------
    # 8. Países (Countries) - Mais de 40
    # -------------------------------------------------
    puts "Seeding Countries..."
    Country.destroy_all
    countries = [
      { name: 'Brazil', code: 'BR', flag_code: 'BR' }, { name: 'United States', code: 'US', flag_code: 'US' },
      { name: 'United Kingdom', code: 'GB', flag_code: 'GB' }, { name: 'Japan', code: 'JP', flag_code: 'JP' },
      { name: 'Germany', code: 'DE', flag_code: 'DE' }, { name: 'France', code: 'FR', flag_code: 'FR' },
      { name: 'Canada', code: 'CA', flag_code: 'CA' }, { name: 'Australia', code: 'AU', flag_code: 'AU' },
      { name: 'Italy', code: 'IT', flag_code: 'IT' }, { name: 'Spain', code: 'ES', flag_code: 'ES' },
      { name: 'Netherlands', code: 'NL', flag_code: 'NL' }, { name: 'Sweden', code: 'SE', flag_code: 'SE' },
      { name: 'Norway', code: 'NO', flag_code: 'NO' }, { name: 'Denmark', code: 'DK', flag_code: 'DK' },
      { name: 'Finland', code: 'FI', flag_code: 'FI' }, { name: 'Belgium', code: 'BE', flag_code: 'BE' },
      { name: 'Switzerland', code: 'CH', flag_code: 'CH' }, { name: 'Austria', code: 'AT', flag_code: 'AT' },
      { name: 'Ireland', code: 'IE', flag_code: 'IE' }, { name: 'Portugal', code: 'PT', flag_code: 'PT' },
      { name: 'Mexico', code: 'MX', flag_code: 'MX' }, { name: 'Argentina', code: 'AR', flag_code: 'AR' },
      { name: 'Chile', code: 'CL', flag_code: 'CL' }, { name: 'Colombia', code: 'CO', flag_code: 'CO' },
      { name: 'Peru', code: 'PE', flag_code: 'PE' }, { name: 'India', code: 'IN', flag_code: 'IN' },
      { name: 'South Korea', code: 'KR', flag_code: 'KR' }, { name: 'China', code: 'CN', flag_code: 'CN' },
      { name: 'Russia', code: 'RU', flag_code: 'RU' }, { name: 'Poland', code: 'PL', flag_code: 'PL' },
      { name: 'Czech Republic', code: 'CZ', flag_code: 'CZ' }, { name: 'Hungary', code: 'HU', flag_code: 'HU' },
      { name: 'New Zealand', code: 'NZ', flag_code: 'NZ' }, { name: 'South Africa', code: 'ZA', flag_code: 'ZA' },
      { name: 'Egypt', code: 'EG', flag_code: 'EG' }, { name: 'Israel', code: 'IL', flag_code: 'IL' },
      { name: 'Turkey', code: 'TR', flag_code: 'TR' }, { name: 'Greece', code: 'GR', flag_code: 'GR' },
      { name: 'Iceland', code: 'IS', flag_code: 'IS' }, { name: 'Jamaica', code: 'JM', flag_code: 'JM' },
      { name: 'Nigeria', code: 'NG', flag_code: 'NG' }, { name: 'Kenya', code: 'KE', flag_code: 'KE' }
    ]
    countries.each { |country| Country.create!(country) }
    puts "#{Country.count} countries created."

    puts "✅ Support tables seeded successfully!"
  end

  # -------------------------------------------------
  # 0. Media Physycal / Tracks - Mais de 800
  # -------------------------------------------------

  desc "Populates main data tables (media_physicals, tracks, etc.) with sample data"
  task seed_main_data: :environment do
    puts "Starting to seed main data tables..."

    # Limpa as tabelas principais antes de popular (ordem importa por causa das chaves estrangeiras)
    puts "Cleaning existing main data..."
    Track.destroy_all
    VinylDetail.destroy_all
    CdDetail.destroy_all
    DvdDetail.destroy_all
    BluRayDetail.destroy_all
    CassetteDetail.destroy_all
    MediaPhysical.destroy_all
    puts "Existing data cleaned."

    # Busca os IDs das tabelas de suporte para usar como referência
    media_type_ids = MediaType.pluck(:name, :id).to_h
    record_label_ids = RecordLabel.pluck(:id)
    imprint_ids = Imprint.pluck(:id)
    genre_ids = Genre.pluck(:id)
    country_ids = Country.pluck(:id, :code).to_h # Pega ID e o código do país para o ISRC
    release_type_ids = ReleaseType.pluck(:id)
    cassette_type_ids = CassetteType.pluck(:id)
    cassette_duration_ids = CassetteDuration.pluck(:id)

    # -------------------------------------------------
    # MÉTODO AUXILIAR PARA GERAR ISRC
    # -------------------------------------------------
    def generate_isrc(country_code, release_year)
      registrant_code = Faker::Alphanumeric.alphanumeric(number: 3).upcase
      designation_code = Faker::Number.number(digits: 5).to_s.rjust(5, '0')
      "#{country_code}#{registrant_code}#{release_year.to_s.last(2)}#{designation_code}"
    end

    # -------------------------------------------------
    # 1. CRIAR 135 VINHIS (ALTERADO DE 25)
    # -------------------------------------------------
    puts "Seeding 135 Vinyl records..."
    135.times do |i|
      country_id = country_ids.keys.sample
      country_code = country_ids[country_id]
      release_year = Faker::Number.between(from: 1970, to: 2023)

      media = MediaPhysical.create!(
        media_type_id: media_type_ids['Vinyl'],
        album_title: Faker::Music.album,
        artist_band: Faker::Music.band,
        record_label_id: record_label_ids.sample,
        imprint_id: imprint_ids.sample,
        genre_id: genre_ids.sample,
        country_id: country_id,
        release_year: release_year,
        release_type_id: release_type_ids.sample,
        barcode: Faker::Barcode.ean(13),
        label_code: Faker::Alphanumeric.alphanumeric(number: 10),
        general_notes: Faker::Lorem.paragraph(sentence_count: 2)
      )

      media.create_vinyl_detail!(
        disc_quantity: Faker::Number.between(from: 1, to: 2),
        size: VinylDetail::SIZES.sample,
        speed: VinylDetail::SPEEDS.sample,
        color: VinylDetail::COLORS.sample,
        edition: VinylDetail::EDITIONS.sample,
        matrix_number: Faker::Alphanumeric.alphanumeric(number: 8).upcase
      )

      # MUDANÇA 2: Define o artista principal da faixa uma vez por álbum
      main_track_artist = media.artist_band

      # MUDANÇA 3: Define quais 2 faixas terão participação especial
      total_tracks = 24 # 12 por lado * 2 lados
      featured_track_indices = (0..total_tracks - 1).to_a.sample(2)
      track_index_counter = 0

      tracks_to_create = []
      ['A', 'B'].each do |side|
        12.times do |track_num|
          # MUDANÇA 3: Verifica se esta faixa está no índice das selecionadas
          has_featured_artist = featured_track_indices.include?(track_index_counter)

          tracks_to_create << {
            track_number: track_num + 1,
            side: side,
            track_title: Faker::Lorem.words(number: 3).join(' ').titleize,
            # MUDANÇA 2: Usa o artista principal definido acima
            track_artist_name: main_track_artist,
            composer: "#{Faker::Name.first_name} #{Faker::Name.last_name}",
            # MUDANÇA 3: Atribui feat. apenas se a faixa foi sorteada
            featured_artist: has_featured_artist ? Faker::Music.band : nil,
            duration: "#{Faker::Number.between(from: 1, to: 5)}:#{Faker::Number.between(from: 10, to: 59).to_s.rjust(2, '0')}",
            isrc: generate_isrc(country_code, release_year),
            track_notes: Faker::Lorem.sentence
          }
          track_index_counter += 1
        end
      end
      media.tracks.create!(tracks_to_create)
      print "."
    end
    puts " 135 Vinyls created!"

    # -------------------------------------------------
    # 2. CRIAR 450 CDS
    # -------------------------------------------------
    puts "Seeding 450 CD records..."
    450.times do |i|
      country_id = country_ids.keys.sample
      country_code = country_ids[country_id]
      release_year = Faker::Number.between(from: 1985, to: 2023)

      disc_quantity = case i
                      when 0..375 then 1
                      when 376..425 then 2
                      when 426..450 then 4
                      end

      media = MediaPhysical.create!(
        media_type_id: media_type_ids['CD'],
        album_title: Faker::Music.album,
        artist_band: Faker::Music.band,
        record_label_id: record_label_ids.sample,
        imprint_id: imprint_ids.sample,
        genre_id: genre_ids.sample,
        country_id: country_id,
        release_year: release_year,
        release_type_id: release_type_ids.sample,
        barcode: Faker::Barcode.ean(13),
        label_code: Faker::Alphanumeric.alphanumeric(number: 10),
        general_notes: Faker::Lorem.paragraph(sentence_count: 2)
      )

      media.create_cd_detail!(disc_quantity: disc_quantity)

      # MUDANÇA 2: Define o artista principal da faixa uma vez por álbum
      main_track_artist = media.artist_band

      tracks_to_create = []
      total_tracks = 0
      track_counts_per_disc = []

      disc_quantity.times do |disc_num|
        track_count = Faker::Number.between(from: 14, to: 16)
        track_counts_per_disc << track_count
        total_tracks += track_count
      end

      # MUDANÇA 3: Define quais 2 faixas terão participação especial
      featured_track_indices = (0..total_tracks - 1).to_a.sample(2)
      track_index_counter = 0

      disc_quantity.times do |disc_num|
        track_count = track_counts_per_disc[disc_num]
        track_count.times do |track_num|
          has_featured_artist = featured_track_indices.include?(track_index_counter)

          tracks_to_create << {
            disc_number: disc_num + 1,
            track_number: track_num + 1,
            track_title: Faker::Lorem.words(number: 3).join(' ').titleize,
            track_artist_name: main_track_artist, # MUDANÇA 2
            composer: "#{Faker::Name.first_name} #{Faker::Name.last_name}",
            featured_artist: has_featured_artist ? Faker::Music.band : nil, # MUDANÇA 3
            duration: "#{Faker::Number.between(from: 2, to: 7)}:#{Faker::Number.between(from: 10, to: 59).to_s.rjust(2, '0')}",
            isrc: generate_isrc(country_code, release_year),
            track_notes: Faker::Lorem.sentence
          }
          track_index_counter += 1
        end
      end
      media.tracks.create!(tracks_to_create)
      print "."
    end
    puts " 450 CDs created!"

    # -------------------------------------------------
    # 3. CRIAR 190 DVDS
    # -------------------------------------------------
    puts "Seeding 190 DVD records..."
    190.times do |i|
      country_id = country_ids.keys.sample
      country_code = country_ids[country_id]
      release_year = Faker::Number.between(from: 1995, to: 2023)

      disc_quantity = (i < 171) ? 1 : 2

      media = MediaPhysical.create!(
        media_type_id: media_type_ids['DVD'],
        album_title: Faker::Music.album,
        artist_band: Faker::Music.band,
        record_label_id: record_label_ids.sample,
        imprint_id: imprint_ids.sample,
        genre_id: genre_ids.sample,
        country_id: country_id,
        release_year: release_year,
        release_type_id: release_type_ids.sample,
        barcode: Faker::Barcode.ean(13),
        label_code: Faker::Alphanumeric.alphanumeric(number: 10),
        general_notes: Faker::Lorem.paragraph(sentence_count: 2)
      )

      media.create_dvd_detail!(disc_quantity: disc_quantity)

      main_track_artist = media.artist_band # MUDANÇA 2
      tracks_to_create = []
      total_tracks = 0
      track_counts_per_disc = []

      disc_quantity.times do |disc_num|
        track_count = Faker::Number.between(from: 16, to: 20)
        track_counts_per_disc << track_count
        total_tracks += track_count
      end

      featured_track_indices = (0..total_tracks - 1).to_a.sample(2) # MUDANÇA 3
      track_index_counter = 0

      disc_quantity.times do |disc_num|
        track_count = track_counts_per_disc[disc_num]
        track_count.times do |track_num|
          has_featured_artist = featured_track_indices.include?(track_index_counter)

          tracks_to_create << {
            disc_number: disc_num + 1,
            track_number: track_num + 1,
            track_title: Faker::Lorem.words(number: 4).join(' ').titleize,
            track_artist_name: main_track_artist, # MUDANÇA 2
            composer: "#{Faker::Name.first_name} #{Faker::Name.last_name}",
            featured_artist: has_featured_artist ? Faker::Music.band : nil, # MUDANÇA 3
            duration: "#{Faker::Number.between(from: 3, to: 10)}:#{Faker::Number.between(from: 10, to: 59).to_s.rjust(2, '0')}",
            isrc: generate_isrc(country_code, release_year),
            track_notes: Faker::Lorem.sentence
          }
          track_index_counter += 1
        end
      end
      media.tracks.create!(tracks_to_create)
      print "."
    end
    puts " 190 DVDs created!"

    # -------------------------------------------------
    # 4. CRIAR 80 BLU-RAYS (ALTERADO DE 15)
    # -------------------------------------------------
    puts "Seeding 80 Blu-ray records..."
    80.times do |i|
      country_id = country_ids.keys.sample
      country_code = country_ids[country_id]
      release_year = Faker::Number.between(from: 2006, to: 2023)

      disc_quantity = (i < 64) ? 1 : 2

      media = MediaPhysical.create!(
        media_type_id: media_type_ids['Blu-Ray'],
        album_title: Faker::Music.album,
        artist_band: Faker::Music.band,
        record_label_id: record_label_ids.sample,
        imprint_id: imprint_ids.sample,
        genre_id: genre_ids.sample,
        country_id: country_id,
        release_year: release_year,
        release_type_id: release_type_ids.sample,
        barcode: Faker::Barcode.ean(13),
        label_code: Faker::Alphanumeric.alphanumeric(number: 10),
        general_notes: Faker::Lorem.paragraph(sentence_count: 2)
      )

      media.create_blu_ray_detail!(disc_quantity: disc_quantity)

      main_track_artist = media.artist_band # MUDANÇA 2
      tracks_to_create = []
      total_tracks = 0
      track_counts_per_disc = []

      disc_quantity.times do |disc_num|
        track_count = Faker::Number.between(from: 15, to: 18)
        track_counts_per_disc << track_count
        total_tracks += track_count
      end

      featured_track_indices = (0..total_tracks - 1).to_a.sample(2) # MUDANÇA 3
      track_index_counter = 0

      disc_quantity.times do |disc_num|
        track_count = track_counts_per_disc[disc_num]
        track_count.times do |track_num|
          has_featured_artist = featured_track_indices.include?(track_index_counter)

          tracks_to_create << {
            disc_number: disc_num + 1,
            track_number: track_num + 1,
            track_title: Faker::Lorem.words(number: 4).join(' ').titleize,
            track_artist_name: main_track_artist, # MUDANÇA 2
            composer: "#{Faker::Name.first_name} #{Faker::Name.last_name}",
            featured_artist: has_featured_artist ? Faker::Music.band : nil, # MUDANÇA 3
            duration: "#{Faker::Number.between(from: 4, to: 12)}:#{Faker::Number.between(from: 10, to: 59).to_s.rjust(2, '0')}",
            isrc: generate_isrc(country_code, release_year),
            track_notes: Faker::Lorem.sentence
          }
          track_index_counter += 1
        end
      end
      media.tracks.create!(tracks_to_create)
      print "."
    end
    puts " 80 Blu-rays created!"

    # -------------------------------------------------
    # 5. CRIAR 67 FITAS CASSETE (ALTERADO DE 15)
    # -------------------------------------------------
    puts "Seeding 67 Cassette records..."
    67.times do |i|
      country_id = country_ids.keys.sample
      country_code = country_ids[country_id]
      release_year = Faker::Number.between(from: 1965, to: 2000)

      media = MediaPhysical.create!(
        media_type_id: media_type_ids['Cassette Tape'],
        album_title: Faker::Music.album,
        artist_band: Faker::Music.band,
        record_label_id: record_label_ids.sample,
        imprint_id: imprint_ids.sample,
        genre_id: genre_ids.sample,
        country_id: country_id,
        release_year: release_year,
        release_type_id: release_type_ids.sample,
        barcode: Faker::Barcode.ean(13),
        label_code: Faker::Alphanumeric.alphanumeric(number: 10),
        general_notes: Faker::Lorem.paragraph(sentence_count: 2)
      )

      media.create_cassette_detail!(
        cassette_type_id: cassette_type_ids.sample,
        cassette_duration_id: cassette_duration_ids.sample,
        disc_quantity: 1
      )

      main_track_artist = media.artist_band # MUDANÇA 2

      total_tracks = 16 # 8 por lado * 2 lados
      featured_track_indices = (0..total_tracks - 1).to_a.sample(2) # MUDANÇA 3
      track_index_counter = 0

      tracks_to_create = []
      ['A', 'B'].each do |side|
        8.times do |track_num|
          has_featured_artist = featured_track_indices.include?(track_index_counter)

          tracks_to_create << {
            track_number: track_num + 1,
            side: side,
            track_title: Faker::Lorem.words(number: 3).join(' ').titleize,
            track_artist_name: main_track_artist, # MUDANÇA 2
            composer: "#{Faker::Name.first_name} #{Faker::Name.last_name}",
            featured_artist: has_featured_artist ? Faker::Music.band : nil, # MUDANÇA 3
            duration: "#{Faker::Number.between(from: 2, to: 5)}:#{Faker::Number.between(from: 10, to: 59).to_s.rjust(2, '0')}",
            isrc: generate_isrc(country_code, release_year),
            track_notes: Faker::Lorem.sentence
          }
          track_index_counter += 1
        end
      end
      media.tracks.create!(tracks_to_create)
      print "."
    end
    puts " 67 Cassettes created!"

    puts "\n✅ Main data tables seeded successfully!"
  end

end
