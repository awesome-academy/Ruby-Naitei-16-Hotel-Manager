module BookingsHelper
  def total_calculate booking
    start_date = booking.checkin.to_date
    end_date = booking.checkout.to_date
    (start_date..end_date).count * booking.room.room_type.cost
  end
end
