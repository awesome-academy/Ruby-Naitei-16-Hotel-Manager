class Admin::RoomTypesController < AdminController
  def new
    @room_type = RoomType.new
  end

  def create
    @room_type = RoomType.new room_type_params
    @room_type.images.attach(params[:room_type][:images])
    if @room_type.save
      flash[:success] = t ".success"
      redirect_to @room_type
    else
      flash[:danger] = t ".fail"
      render :new
    end
  end

  private
  def room_type_params
    params.require(:room_type).permit RoomType::ROOMTYPE_PERMITTED
  end
end
