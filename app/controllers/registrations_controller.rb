class RegistrationsController < Devise::RegistrationsController
    before_action :configure_sign_up_params, only: [:create]

  def create
    super do |user|
      user.name = sign_up_params[:name]
      user.user_type = sign_up_params[:user_type]
    end
  end
    protected
  
    def configure_sign_up_params
      devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :user_type])
    end
  end
  
  # if sign_up_params[:user_type].present?