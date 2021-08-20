class RemoveBookingDateFromBooking < ActiveRecord::Migration[6.1]
  def change
    remove_column :bookings, :booking_date, :datetime
  end
end
