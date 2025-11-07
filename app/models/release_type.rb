class ReleaseType < ApplicationRecord
  has_many :media_physicals, dependent: :restrict_with_error

  validates :name, presence: true, uniqueness: { case_sensitive: false }

  # Constants for release types
  STUDIO_ALBUM = 'Álbum de Estúdio'
  LIVE = 'Ao Vivo'
  COMPILATION = 'Coletânea'
  SINGLE = 'Single'
  EP = 'EP'
end
