class MediaType < ApplicationRecord
  has_many :media_physicals, dependent: :restrict_with_error

  validates :name, presence: true,  uniqueness: { case_sensitive: false }

  # Constants for media types
  VINYL = 'Vinyl'   #'Disco de Vinil'
  CD = 'CD'
  DVD = 'DVD'
  BLURAY = "Blu-Ray"
  CASSETTE = 'Cassette Tape'   # 'Fita Cassete'

end
