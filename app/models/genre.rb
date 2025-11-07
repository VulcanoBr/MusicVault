class Genre < ApplicationRecord
  has_many :media_physicals, dependent: :restrict_with_error

  validates :name, presence: true, uniqueness: { case_sensitive: false }
end
