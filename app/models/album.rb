class Album < ApplicationRecord
  validates :title, :year, :band_id, presence: true

  belongs_to :artist,
    class_name: :Band,
    primary_key: :id,
    foreign_key: :band_id
end 