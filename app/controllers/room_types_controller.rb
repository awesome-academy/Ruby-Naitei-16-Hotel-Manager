class RoomTypesController < ApplicationController
  def show
    @room_type = RoomType.find_by slug: params[:id]
    if @room_type
      @rooms = Room.available.by_room_type_id @room_type.id
    else
      flash[:warning] = t ".not_found"
      redirect_to root_path
    end
  end
end
