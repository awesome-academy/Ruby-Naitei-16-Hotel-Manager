class RoomsController < ApplicationController
  def index
    @rooms = if params[:room_type].present?
               RoomType.find_by(id: params[:room_type]).rooms.available
             else
               Room.available
             end

    return unless request.xhr?

    respond_to do |format|
      format.json{render json: {rooms: @rooms}}
    end
  end

  def show
    @room = Room.find_by slug: params[:id]
    if @room
      @room_type = RoomType.find_by id: @room.room_type_id
    else
      flash[:warning] = t ".not_found"
      redirect_to root_path
    end
  end
end
