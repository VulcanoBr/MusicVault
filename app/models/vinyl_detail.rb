class VinylDetail < ApplicationRecord
  belongs_to :media_physical

  validates :disc_quantity, presence: true, numericality: {
    only_integer: true,
    greater_than: 0
  }
  validates :size, inclusion: {
    in: ['12"', '10"', '7"'],
    allow_blank: true
  }
  validates :speed, inclusion: {
    in: ['33 RPM', '45 RPM', '78 RPM'],
    allow_blank: true
  }
  validates :color, length: { maximum: 100 }, allow_blank: true
  validates :edition, length: { maximum: 100 }, allow_blank: true
  validates :matrix_number, length: { maximum: 100 }, allow_blank: true

  # Constants
  SIZES = ['12"', '10"', '7"'].freeze
  SPEEDS = ['33 RPM', '45 RPM', '78 RPM'].freeze
  COLORS = ['Preto', 'Colorido', 'Picture Disc', 'Transparente', 'Splatter'].freeze
  EDITIONS = ['Original', 'Reedição', 'Limitada', 'Especial', 'Importada'].freeze
end
