module RoomTypesHelper
  def link_address origin
    if origin == "booking"
      "#room_type_path"
    elsif origin == "home"
      booking_path
    end
  end

  def link_address_i18n origin
    if origin == "booking"
      "details"
    elsif origin == "home"
      "book_now"
    end
  end
end
