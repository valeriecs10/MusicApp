class Band < ApplicationRecord
  validates :name, presence: true

  has_many :albums,
    class_name: :Album,
    primary_key: :id,
    foreign_key: :band_id
end