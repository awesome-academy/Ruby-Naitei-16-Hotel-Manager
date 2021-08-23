class Booking < ApplicationRecord
  belongs_to :room
  belongs_to :user
  has_one :payment, dependent: :destroy

  attr_accessor :room_type, :total

  PERMITTED = %i(room_id user_id booking_date checkin checkout).freeze

  validates :checkin, presence: true, date: {after: Time.zone.today}
  validates :checkout, presence: true, date: {after: :checkin}

  class << self
    def create_bookings params, room_ids, user_id
      Booking.transaction do
        room_ids.each do |room_id|
          booking = Booking.new booking_params(params, room_id, user_id)
          booking.save!
          Room.transaction do
            booking.room.update!(is_available: false)
            raise ActiveRecord::Rollback
          end
        end
      end
    rescue ActiveRecord::RecordInvalid
      false
    end

    def booking_params params, room_id, user_id
      params[:booking].merge!(room_id: room_id, user_id: user_id)
      params.require(:booking).permit PERMITTED
    end
  end
end
