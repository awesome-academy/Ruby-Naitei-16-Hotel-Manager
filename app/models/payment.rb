class Payment < ApplicationRecord
  belongs_to :user

  after_create :update_after_checkout

  PERMITTED = %i(amount user_id).freeze

  validates :amount, presence: true,
                     numericality: {greater_than: Settings.validation.item.min}

  def update_after_checkout
    User.transaction do
      user.bookings.non_checkout.update_all(is_checkout: true)
      user.rooms.not_available.update_all(is_available: true)
    end
  end
end
