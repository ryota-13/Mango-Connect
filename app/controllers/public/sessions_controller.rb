# frozen_string_literal: true

class Public::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  def guest_sign_in
    user = User.guest 
    sign_in user
    flash[:notice] = "ゲストユーザーとしてログインしました" 
    redirect_to mypage_path
  end

  def after_sign_in_path_for(resource)
    mypage_path  # マイページに遷移
  end

  def after_sign_out_path_for(resource_or_scope)
    root_path  # トップページに遷移
  end



  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
