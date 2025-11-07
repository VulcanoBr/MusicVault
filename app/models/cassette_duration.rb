class CassetteDuration < ApplicationRecord
  has_many :cassette_details, dependent: :restrict_with_error

  validates :name, presence: true, uniqueness: { case_sensitive: false }

  # Constants for cassette durations
  C60 = 'C60'
  C90 = 'C90'
  C120 = 'C120'
  C180 = 'C180'
end
