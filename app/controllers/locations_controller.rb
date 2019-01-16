class LocationsController < ApplicationController
  def index
    @locations = Location.all
  end

  def new
    @location = Location.new
  end

  def create
    location = Location.new(location_params)
    location.user_id = current_user.id

    if location.save
      flash[:notice] = "クリップ完了"
      redirect_to location_path(location.id)
    else
      @location = Location.new
      render "new"
    end
  end

  def show
    @location = Location.find(params[:id])
  end

  def edit
  end

  def update
  end

  def destroy
    location = Location.find(params[:id])
    location.destroy
    redirect_to user_path(current_user)
    flash[:alert] = location.location_name + "を削除しました"
  end

  private
    def location_params
      params.require(:location).permit(:location_name, :location_image, :station, :location_url, :location_memo,
       :address, :latitude, :longitude, :public_status, :user_id)
    end

end
