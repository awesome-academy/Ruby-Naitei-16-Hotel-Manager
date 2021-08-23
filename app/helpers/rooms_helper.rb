module RoomsHelper
  def select_room_type
    RoomType.pluck :description, :id
  end

  def show_room room
    t(".title") + room.room_number
  end
end
