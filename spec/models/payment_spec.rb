require "rails_helper"
RSpec.describe Payment, type: :model do
  let(:user) {FactoryBot.create :user}
  let(:room) {FactoryBot.create :room}
  let(:booking) {FactoryBot.create :booking, user: user, room: room}
  describe "validations" do
    it do
      should validate_numericality_of(:amount)
      .is_greater_than(Settings.validation.item.min)
    end
    it { should validate_presence_of(:amount) }
  end

  describe "associations" do
    it { should belong_to :user }
  end

  describe "#create" do
    let!(:payment) {FactoryBot.create :payment, user: user}
    it "update room after checkout" do
      user.bookings.push(booking)
      user.bookings.non_checkout.update_all(is_checkout: true)
      user.bookings.first.update(is_checkout: false)
      user.rooms.update_all(is_available: false)
      expect(user.rooms.not_available.update_all(is_available: true)).to_not eq 0
    end

    it "update booking after checkout" do
      user.bookings.push(booking)
      expect(user.bookings.non_checkout.update_all(is_checkout: true)).to_not eq 0
    end
  end
end
