class UsersController < ApplicationController
  before_action :authenticate_user!, :only => [:clip, :show]

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
    if current_user.is_friend?(@user)
      @location = Location.where(user_id: @user.id)
      if @user.id == current_user.id
        @entries = current_user.entries
      else
        @room = Room.new
        @entry = Entry.new
      end
    elsif current_user.id == @user.id
      @location = Location.where(user_id: @user.id)
      if @user.id == current_user.id
        @entries = current_user.entries
      else
        @room = Room.new
        @entry = Entry.new
      end
    else
      flash[:alert] = "そのユーザーとはフレンドではないためそのページへは行けません"
      redirect_to user_path(current_user.id)
    end
  end

  def update
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    flash[:alert] = "アカウントを削除しました"
    redirect_to root_path
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
