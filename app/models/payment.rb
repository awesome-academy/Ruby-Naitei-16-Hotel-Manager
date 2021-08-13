class Payment < ApplicationRecord
  validates :amount, presence: true,
                     numericality: {greater_than: Settings.validation.item.min}
end
