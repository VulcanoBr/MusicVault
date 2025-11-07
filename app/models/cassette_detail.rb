class CassetteDetail < ApplicationRecord
  belongs_to :media_physical
  belongs_to :cassette_type, optional: true
  belongs_to :cassette_duration, optional: true

  validates :cassette_type_id, presence: true, if: -> { cassette_duration_id.present? }
end
