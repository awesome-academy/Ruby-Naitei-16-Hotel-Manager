module RoomsHelper
  def select_room_type
    RoomType.pluck(:description, :id)
  end

  def display_image image
    image.variant resize: Settings.room.image_size
  end

  def show_room
    t(".title") + @room.room_number
  end
end
