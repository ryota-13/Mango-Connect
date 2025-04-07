class Public::UsersController < ApplicationController
  before_action :authenticate_user!

  # マイページ表示
  def mypage
    @user = current_user
    @posts = @user.posts
  end

  # ユーザー詳細画面
  def show
    @user = User.find(params[:id])
    @posts = @user.posts
  end

  # プロフィール編集画面
  def edit
    @user = current_user
  end

  # プロフィール更新
  def update
    @user = current_user
    if @user.update(user_params)
      redirect_to mypage_path, notice: 'プロフィールを更新しました'
    else
      render :edit
    end
  end

  # 退会処理
  def destroy
    @user = current_user
    @user.destroy
    redirect_to root_path, notice: 'アカウントが削除されました'
  end

  private

  def user_params
    params.require(:user).permit(:name, :profile, :email, :password, :password_confirmation, :image)
  end
end

