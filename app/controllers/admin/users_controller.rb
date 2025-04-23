class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_user, only: [:show, :destroy]

  def index
    @users = User.page(params[:page]).per(10)
  end

  def show
    @posts = @user.posts
    @posts = @user.posts.page(params[:page]).per(16)
  end

  def destroy
    @user.destroy
    flash[:notice] = "ユーザーを退会処理しました"
    redirect_to admin_users_path
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

end
