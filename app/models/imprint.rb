class Imprint < ApplicationRecord
  has_many :media_physicals, dependent: :restrict_with_error

  validates :name, presence: true, uniqueness: true
end
