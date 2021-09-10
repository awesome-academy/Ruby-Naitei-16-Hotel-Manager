class Room < ApplicationRecord
  has_many :bookings, dependent: :destroy
  has_many :users, through: :bookings
  has_many :reviews, as: :commentable, dependent: :destroy
  belongs_to :room_type

  extend FriendlyId
  friendly_id :room_number, use: :slugged

  ROOM_PERMITTED = %i(room_number description room_type_id).freeze

  validates :room_number, presence: true
  validates :description, presence: true,
                  length: {maximum: Settings.validation.description.length.max}

  scope :available, ->{where(is_available: true)}
  scope :not_available, ->{where(is_available: false)}
  scope :by_room_type_id, ->(room_type){where(room_type_id: room_type)}

  rails_admin do
    create do
      exclude_fields :bookings, :users, :reviews
    end
    edit do
      exclude_fields :bookings, :users, :reviews
    end
  end

  def normalize_friendly_id text
    ["room", text].join("-")
  end
end
