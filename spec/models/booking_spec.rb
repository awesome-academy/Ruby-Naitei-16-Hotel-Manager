require "rails_helper"

RSpec.describe Booking, type: :model do
  let(:booking) {FactoryBot.create :booking}
  let(:user) {FactoryBot.create :user}
  let(:room_1) {FactoryBot.create :room}
  let(:room_2) {FactoryBot.create :room}
  let(:room_ids) {[room_1.id, room_2.id]}
  let(:params) {ActionController::Parameters.new({
    booking: {
      checkin: DateTime.now + 1.day,
      checkout: DateTime.now + 2.day
    }
  })}

  describe ".count_by_room_type" do
    it "return bookings group by room type" do
      booking.save
      bookings = Booking.joins(room: :room_type)
                        .where(
                          "bookings.created_at >= ?",
                          Time.zone.now - Settings.statistic.default.month_ago.months
                        )
                        .group(:room_type_id)
                        .count
      expect(Booking.count_by_room_type).to eq bookings
    end
  end

  describe "create multiple bookings" do
    it "return true if successfully" do
      expect(Booking.create_bookings(params, room_ids, user.id)).to_not eq false
    end
    it "return false if has exception" do
      room_2.destroy!
      expect(Booking.create_bookings(params, room_ids, user.id)).to eq false
    end
  end

  describe "#duration" do
    it "return string of duration" do
      duration = [booking.checkin.to_date, booking.checkout.to_date].join(" -> ")
      expect(booking.duration).to eq duration
    end
  end

  describe "#destroy" do
    before {booking.destroy!}
    it "update room status" do
      expect(booking.room.update! is_available: true).to eq true
    end
  end
end
