module PaymentsHelper
  def booking_calculate booking
    start_date = booking.checkin.to_date
    end_date = booking.checkout.to_date
    (start_date..end_date).count * booking.room.room_type.cost
  end

  def total_bill_calculate bookings
    bookings.map{|booking| booking_calculate booking}.inject(:+)
  end

  def paid_to_text is_paid
    is_paid ? t(".paid") : t(".unpaid")
  end
end
