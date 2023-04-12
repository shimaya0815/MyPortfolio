class ApplicationController < ActionController::Base
  before_action :authenticate_user!, except: [:top, :about] # top, about の2つのアクションのみログインしなくてアクセス可能にする
  before_action :configure_permitted_parameters, if: :devise_controller?

  def after_sign_in_path_for(resource)
    user_path(current_user) # ログインした直後は、ユーザーの詳細ページに遷移
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email])
  end

  Refile.secret_key = '6d3afaec3778601452c9243ffdb9fcb961d0c0a15f67ed92000e90e48da5ff87e516874864c476603d97748790b1115498be278b6629b1479adc2e2d96295411'
end
