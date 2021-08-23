class RoomType < ApplicationRecord
  has_many :rooms, dependent: :destroy
  accepts_nested_attributes_for :rooms

  has_many_attached :images
  ROOMTYPE_PERMITTED = %i(name cost bed_num air_conditioner description).freeze

  validates :name, presence: true
  validates :description, presence: true,
                  length: {maximum: Settings.validation.description.length.max}
  validates :bed_num, :cost, presence: true,
                  numericality: {greater_than: Settings.validation.item.min}
  validates :images,
            content_type: {
              in: Settings.validation.image.type,
              message: :invalid_format
            },
            size: {
              less_than: Settings.validation.image.max_size.megabytes,
              message: :required_size
            }

  scope :most_available, (lambda do
    joins(:rooms)
      .select("room_types.*, count(rooms.id) as available_number")
      .where("rooms.is_available = true")
      .group(:id)
      .order(available_number: :desc)
  end)
end
