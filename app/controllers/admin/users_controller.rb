class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!

  def index
    @users = User.page(params[:page]).per(10)
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.order(created_at: :desc).page(params[:page]).per(16)
  end  

  def destroy
    user = User.find(params[:id])
    user.destroy
    flash[:notice] = "ユーザーを退会処理しました"
    redirect_to admin_users_path
  end
end

