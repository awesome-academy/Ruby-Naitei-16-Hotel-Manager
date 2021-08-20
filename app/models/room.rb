class Room < ApplicationRecord
  has_many :bookings, dependent: :destroy
  has_many :users, through: :bookings
  has_many :reviews, as: :commentable, dependent: :destroy
  belongs_to :room_type

  ROOM_PERMITTED = %i(room_number description room_type_id).freeze

  validates :room_number, presence: true
  validates :description, presence: true,
                  length: {maximum: Settings.validation.description.length.max}

  scope :available, ->{where(is_available: true)}
  scope :by_room_type_id, ->(room_type){where(room_type_id: room_type)}
end
