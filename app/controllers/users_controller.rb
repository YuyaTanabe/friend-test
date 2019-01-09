class UsersController < ApplicationController

  def index
    @users = User.all

  end

  def show
    @user = User.find(params[:id])

  end

  def update
  end

  def destroy
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
