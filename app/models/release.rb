class Release < ApplicationRecord
  has_one :album
  has_many :artist_releases, dependent: :destroy
  has_many :artists, through: :artist_releases

  INDEX_PARAMS = %i[past limit page].freeze
end
