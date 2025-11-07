class CassetteType < ApplicationRecord
  has_many :cassette_details, dependent: :restrict_with_error

  validates :name, presence: true, uniqueness: { case_sensitive: false }

  # Constants for cassette types
  NORMAL = 'Normal'
  CRO2 = 'CrO2'
  METAL = 'Metal'
end
