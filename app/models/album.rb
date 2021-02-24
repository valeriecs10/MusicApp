class Album < ApplicationRecord
  validates :title, :year, :band_id, presence: true

  belongs_to :artist,
    class_name: :Band,
    primary_key: :id,
    foreign_key: :band_id

  has_many :tracks,
    dependent: :destroy
end 