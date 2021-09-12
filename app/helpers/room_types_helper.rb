module RoomTypesHelper
  def display_image image
    image.variant resize: Settings.room_types.image_size
  end

  def show_room_type
    t(".title") + @room_type.name
  end
end
