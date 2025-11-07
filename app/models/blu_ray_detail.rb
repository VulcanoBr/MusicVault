class BluRayDetail < ApplicationRecord
  belongs_to :media_physical

  validates :disc_quantity, presence: true, numericality: {
    only_integer: true,
    greater_than: 0
  }
end
