class Booking < ApplicationRecord
  belongs_to :room
  belongs_to :user

  delegate :room_number, to: :room
  delegate :duration, to: :class

  attr_accessor :room_type, :total

  PERMITTED = %i(room_id user_id checkin checkout).freeze

  after_destroy :update_room_status

  validates :checkin, presence: true, date: {after: Time.zone.today}
  validates :checkout, presence: true, date: {after: :checkin}

  scope :non_checkout, ->{where is_checkout: false}
  scope :recent, ->{order created_at: :desc}
  scope :count_by_room_type, (lambda do
    joins(room: :room_type)
      .where(
        "bookings.created_at >= ?",
        Time.zone.now - Settings.statistic.default.month_ago.months
      )
      .group(:room_type_id)
      .count
  end)

  class << self
    def create_bookings params, room_ids, user_id
      Booking.transaction do
        room_ids.each do |room_id|
          booking = Booking.new booking_params(params, room_id, user_id)
          booking.save!
          Room.transaction do
            booking.room.update! is_available: false
            raise ActiveRecord::Rollback
          end
        end
      end
    rescue ActiveRecord::RecordInvalid
      false
    end

    def booking_params params, room_id, user_id
      params[:booking].merge! room_id: room_id, user_id: user_id
      params.require(:booking).permit PERMITTED
    end
  end

  def duration
    [checkin.to_date, checkout.to_date].join(" -> ")
  end

  private

  def update_room_status
    room.update! is_available: true
  end
end
