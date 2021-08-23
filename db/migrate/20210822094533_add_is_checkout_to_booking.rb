class AddIsCheckoutToBooking < ActiveRecord::Migration[6.1]
  def change
    add_column :bookings, :is_checkout, :boolean, default: false
  end
end
