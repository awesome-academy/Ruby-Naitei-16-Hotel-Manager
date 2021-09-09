class Payment < ApplicationRecord
  belongs_to :user

  after_create :update_after_checkout

  PERMITTED = %i(amount user_id).freeze

  validates :amount, presence: true,
                     numericality: {greater_than: Settings.validation.item.min}

  scope :total_revenue, (lambda do
    where(
      "created_at >= ?",
      Time.zone.now - Settings.statistic.default.month_ago.months
    ).sum(:amount)
  end)
  scope :revenue_by_month, (lambda do
    group_by_month(
      :created_at,
      last: Settings.statistic.default.month_ago,
      format: "%b %Y"
    ).sum(:amount)
  end)

  def update_after_checkout
    User.transaction do
      user.bookings.non_checkout.update_all(is_checkout: true)
      user.rooms.not_available.update_all(is_available: true)
    end
  end
end
