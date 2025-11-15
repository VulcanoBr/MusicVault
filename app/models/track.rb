class Track < ApplicationRecord
  belongs_to :media_physical, inverse_of: :tracks

  SIDES = %w[A B C D].freeze

  validates :track_number, presence: true, numericality: {
    only_integer: true,
    greater_than: 0
  }
  validates :disc_number, numericality: {
    only_integer: true,
    greater_than: 0
  }, allow_nil: true
  validates :side, inclusion: {
    in: %w[A B C D],
    allow_blank: true
  }

  validates :duration, presence: true, format: { with: /\A\d{1,2}:\d{2}\z/, message: "deve estar no formato MM:SS" }
  validates :track_title, presence: true
  validates :track_artist_name, length: { maximum: 255 }, allow_blank: true
  validates :composer, length: { maximum: 255 }, allow_blank: true
  validates :featured_artist, length: { maximum: 255 }, allow_blank: true
  validates :isrc,
    length: { is: 12, message: "deve ter 12 caracteres" },
    format: {
      with: /\A[A-Z]{2}[A-Z0-9]{3}\d{2}\d{5}\z/,
      message: "formato inválido (ex: BRXYZ2300123)"
    },
    uniqueness: true,
    allow_blank: true

  # Scopes
  scope :ordered, -> { order(:disc_number, :side, :track_number) }
  scope :by_disc, ->(disc) { where(disc_number: disc) }
  scope :by_side, ->(side) { where(side: side) }

  # Methods
  def full_title
    parts = [track_number]
    parts << "(Disco #{disc_number})" if disc_number && disc_number > 1
    parts << "Lado #{side}" if side.present?
    parts << track_title
    parts.join(' - ')
  end

  def duration_in_seconds
    return 0 unless duration
    duration.hour * 3600 + duration.min * 60 + duration.sec
  end

  def formatted_duration
    return '--:--' unless duration
    duration #.strftime('%M:%S')
  end
end
