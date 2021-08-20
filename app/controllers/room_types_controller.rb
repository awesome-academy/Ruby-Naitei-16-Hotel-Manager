class RoomTypesController < ApplicationController
  def show
    @room_type = RoomType.find_by id: params[:id]
    if @room_type
      @rooms = Room.room_type_id(@room_type.id).is_available
    else
      flash[:warning] = t ".not_found"
      redirect_to root_path
    end
  end
end
