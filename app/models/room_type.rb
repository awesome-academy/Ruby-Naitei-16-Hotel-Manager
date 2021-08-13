class RoomType < ApplicationRecord
  has_many :rooms, dependent: :destroy

  validates :name, presence: true
  validates :description, presence: true,
                  length: {maximum: Settings.validation.description.length.max}
  validates :bed_num, :cost, presence: true,
                  numericality: {greater_than: Settings.validation.item.min}
end
