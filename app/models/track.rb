class Track < ApplicationRecord
  validates :title, :ord, :album_id, presence: true
  validates :title, uniqueness: { scope: :album_id, message: "can't be used twice on the same album"}
  validates :ord, uniqueness: { scope: :album_id, message: "can't be repeated on the same album" }

  belongs_to :album

  has_many :notes,
    dependent: :destroy
end