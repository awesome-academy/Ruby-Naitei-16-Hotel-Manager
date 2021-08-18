class Room < ApplicationRecord
  has_many :bookings, dependent: :destroy
  has_many :users, through: :bookings
  has_many :reviews, as: :commentable, dependent: :destroy
  belongs_to :room_type

  has_many_attached :images
  ROOM_PERMITTED = %i(room_number description room_type_id).freeze

  validates :room_type_id, :room_number, presence: true
  validates :description, presence: true,
                  length: {maximum: Settings.validation.description.length.max}
  validates :images,
            content_type: {
              in: Settings.validation.image.type,
              message: I18n.t("rooms.invalid_format")
            },
            size: {
              less_than: Settings.validation.image.max_size.megabytes,
              message: I18n.t("rooms.required_size")
            }
end
