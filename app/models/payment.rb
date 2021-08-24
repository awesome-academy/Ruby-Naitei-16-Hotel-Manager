class Payment < ApplicationRecord
  belongs_to :user

  after_create :update_after_checkout

  PERMITTED = %i(amount user_id).freeze

  validates :amount, presence: true,
                     numericality: {greater_than: Settings.validation.item.min}

  private

  def update_after_checkout
    Booking.transaction do
      user.bookings.non_checkout.update_all(is_checkout: true)
      Room.transaction do
        user.rooms.not_available.update_all(is_available: true)
        raise ActiveRecord::Rollback
      end
    end
  rescue ActiveRecord::StatementInvalid
    false
  end
end
