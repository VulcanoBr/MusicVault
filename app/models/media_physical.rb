class MediaPhysical < ApplicationRecord
  belongs_to :media_type
  belongs_to :record_label
  belongs_to :imprint, optional: true
  belongs_to :genre
  belongs_to :country
  belongs_to :release_type

  has_one :vinyl_detail, dependent: :destroy
  has_one :cd_detail, dependent: :destroy
  has_one :dvd_detail, dependent: :destroy
  has_one :cassette_detail, dependent: :destroy
  has_one :blu_ray_detail, dependent: :destroy

  has_many :tracks, dependent: :destroy

  has_one_attached :front_cover
  has_one_attached :back_cover

  accepts_nested_attributes_for :vinyl_detail, allow_destroy: true, reject_if: :all_blank
  accepts_nested_attributes_for :cd_detail, allow_destroy: true, reject_if: :all_blank
  accepts_nested_attributes_for :dvd_detail, allow_destroy: true, reject_if: :all_blank
  accepts_nested_attributes_for :blu_ray_detail, allow_destroy: true, reject_if: :all_blank
  accepts_nested_attributes_for :cassette_detail, allow_destroy: true, reject_if: :all_blank
  accepts_nested_attributes_for :tracks, allow_destroy: true, reject_if: :all_blank

  attr_accessor :remove_front_cover, :remove_back_cover

  before_save :purge_covers

  validates :album_title, presence: true
  validates :artist_band, presence: true
  validates :release_year, numericality: {
    only_integer: true,
    greater_than: 1800,
    less_than_or_equal_to: -> { Date.current.year + 1 }
  }, allow_nil: true
  validates :barcode, uniqueness: true, allow_blank: true
  validates :label_code, length: { maximum: 100 }, allow_blank: true

  scope :by_media_type, ->(type) { joins(:media_type).where(media_types: { name: type }) }
  scope :by_artist, ->(artist) { where('artist_band ILIKE ?', "%#{artist}%") }
  scope :by_year, ->(year) { where(release_year: year) }
  scope :by_genre, ->(genre_id) { where(genre_id: genre_id) }
  scope :recent, -> { order(created_at: :desc) }

  def vinyl?
    media_type.name == MediaType::VINYL
  end

  def cd?
    media_type.name == MediaType::CD
  end

  def dvd?
    media_type.name == MediaType::DVD
  end

  def bluray?
    media_type.name == MediaType::BLURAY
  end

  def cassette?
    media_type.name == MediaType::CASSETTE
  end

  def purge_covers
    front_cover.purge if remove_front_cover == '1'
    back_cover.purge if remove_back_cover == '1'
  end

  def specific_detail
    case media_type&.name&.downcase
    when 'vinyl'
      vinyl_detail
    when 'cd'
      cd_detail
    when 'dvd'
      dvd_detail
    when 'blu-ray'
      blu_ray_detail
    when 'fita cassete'
      cassette_detail
    else
      nil
    end
  end

  # Campo calculado para a duração total
  def total_duration
    return nil if tracks.empty?

    total_seconds = tracks.sum do |track|
      next 0 unless track.duration
      parts = track.duration.split(':')
      parts[0].to_i * 60 + parts[1].to_i
    end
    hours = total_seconds / 3600
    minutes = (total_seconds % 3600) / 60
    seconds = total_seconds % 60
    "#{hours.to_s.rjust(2, '0')}:#{minutes.to_s.rjust(2, '0')}:#{seconds.to_s.rjust(2, '0')}"
  end

  def total_tracks
    tracks.count
  end

  def media_detail
    return vinyl_detail if vinyl?
    return cd_detail if cd?
    return dvd_detail if dvd?
    return blu_ray_detail if bluray?
    return cassette_detail if cassette?
    nil
  end

end
