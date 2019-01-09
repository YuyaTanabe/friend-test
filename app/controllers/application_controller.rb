class ApplicationController < ActionController::Base

	before_action :configure_permitted_parameters, if: :devise_controller?
	protect_from_forgery with: :exception



	# def after_sign_out_path_for(resource)
 #  		home_path(resource)
	# end

	def after_sign_in_path_for(resource)
	  users_path
	end

	def after_sign_out_path_for(resource)
	  root_path
	end


protected
	def configure_permitted_parameters
  		devise_parameter_sanitizer.permit(:sign_up, keys: [:user_name, :friend_id, :email, :password, :deleted_at, :password_confirmation])
	end

end