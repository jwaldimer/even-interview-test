class Artist < ApplicationRecord
  has_many :albums
  has_many :artist_releases, dependent: :destroy
  has_many :releases, through: :artist_releases
end
