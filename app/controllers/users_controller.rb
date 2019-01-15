class UsersController < ApplicationController
  # before_action :authenticate_user!, :only => [:clip]


  def index
    if user_signed_in?
      @users = User.all
    else
      flash[:alert] = "ログインしてください"
      redirect_to root_path
    end
  end

  def show
    @user = User.find(params[:id])
    @location = Location.where(user_id: @user.id)
  end

  def update
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to users_path
  end

  def edit
  end

  def clip
  end

  private
    def user_params
      params.require(:user).permit(:user_name, :friend_id, :email, :password, :deleted_at)
    end

end
