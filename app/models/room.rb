class Room < ApplicationRecord
  has_many :bookings, dependent: :destroy
  has_many :users, through: :bookings
  has_many :reviews, as: :commentable, dependent: :destroy
  belongs_to :room_type

  has_many_attached :images

  validates :room_type_id, :room_number, presence: true
  validates :description, presence: true,
                  length: {maximum: Settings.validation.description.length.max}
  validates :image,
            content_type: {
              in: Settings.validation.image.type,
              message: :invalid_format
            },
            size: {
              less_than: Settings.validation.image.max_size.megabytes,
              message: :required_size
            }
end
