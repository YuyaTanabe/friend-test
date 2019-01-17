class AdminsController < ApplicationController
  def show
  end

  private
    def admin_params
      params.require(:admin).permit(:name, :email, :password)
    end
end
