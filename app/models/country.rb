class Country < ApplicationRecord
  has_many :media_physicals, dependent: :restrict_with_error

  validates :name, presence: true, uniqueness: true
  validates :code, presence: true, uniqueness: { case_sensitive: false }
end
