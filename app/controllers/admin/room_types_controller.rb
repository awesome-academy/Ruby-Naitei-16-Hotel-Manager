class Admin::RoomTypesController < AdminController
  before_action :load_room_type, except: %i(new create)
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

  def edit; end

  def show
    @rooms = Room.available.by_room_type_id @room_type.id
    render "room_types/show"
  end

  def update
    if @room_type.update room_type_params
      flash[:success] = t ".success"
      redirect_to @room_type
    else
      flash[:danger] = t ".fail"
      render :edit
    end
  end

  def destroy
    if @room_type.destroy
      flash[:success] = t ".success"
    else
      flash[:danger] = t ".fail"
    end
    redirect_to admin_path
  end

  private
  def room_type_params
    params.require(:room_type).permit RoomType::ROOMTYPE_PERMITTED
  end

  def load_room_type
    @room_type = RoomType.find_by id: params[:id]
    return if @room_type

    flash[:danger] = t ".not_found"
    redirect_to admin_path
  end
end
