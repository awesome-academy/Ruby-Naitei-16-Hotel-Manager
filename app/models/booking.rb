class Booking < ApplicationRecord
  belongs_to :room
  belongs_to :user
  has_one :payment, dependent: :destroy

  validates :checkin, date: {after: :booking_date}
  validates :checkout, date: {after: :checkin}
end
