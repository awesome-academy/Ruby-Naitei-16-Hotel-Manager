class RoomsController < ApplicationController
  def show
    @room = Room.find_by id: params[:id]
    if @room
      @room_type = RoomType.find_by id: @room.room_type_id
    else
      flash[:warning] = t ".not_found"
      redirect_to root_path
    end
  end
end
