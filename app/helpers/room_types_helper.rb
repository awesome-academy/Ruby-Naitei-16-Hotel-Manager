module RoomTypesHelper
  def link_address origin
    if origin == "booking"
      "#room_type_path"
    elsif origin == "home"
      book_path
    end
  end

  def link_address_i18n origin
    if origin == "booking"
      "details"
    elsif origin == "home"
      "book_now"
    end
  end

  def display_image image
    image.variant resize: Settings.room_types.image_size
  end

  def show_room_type
    t(".title") + @room_type.name
  end
end
