class Public::UsersController < ApplicationController
  before_action :authenticate_user!, except: [:show]  
  before_action :ensure_guest_user, only: [:edit]

  # マイページ表示
  def mypage
    @user = current_user
    @posts = @user.posts.page(params[:page]).per(8) 
  end

  # ユーザー詳細画面
  def show
    @user = User.find(params[:id])
    @posts = @user.posts.page(params[:page]).per(8) 
  end

  # プロフィール編集画面
  def edit
    @user = current_user
  end

  # プロフィール更新
  def update
    @user = current_user
    if @user.update(user_params)
      flash[:notice] = "プロフィールを更新しました"
      redirect_to mypage_path
    else
      flash.now[:notice] = "プロフィールの更新に失敗しました"
      render :edit
    end
  end

  # 退会処理
  def destroy
    @user = current_user
    @user.destroy
    flash[:notice] = "アカウントを削除しました"
    redirect_to root_path
  end

  private

  def user_params
    params.require(:user).permit(:name, :profile, :email, :password, :password_confirmation, :image)
  end

  def ensure_guest_user
    @user = User.find(params[:id])
    if @user.guest_user?
      flash[:notice] = "ゲストユーザーはプロフィール編集画面へ遷移できません"
      redirect_to user_path(current_user)
    end
  end 

end

