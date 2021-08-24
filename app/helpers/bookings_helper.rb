module BookingsHelper
  def total_calculate booking
    start_date = booking.checkin.to_date
    end_date = booking.checkout.to_date
    (start_date..end_date).count * booking.room.room_type.cost
  end

  def checkout_to_text is_checkout
    is_checkout ? t(".checkout") : t(".non_checkout")
  end
end
