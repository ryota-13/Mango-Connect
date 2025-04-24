class Public::UsersController < ApplicationController
  before_action :authenticate_user!, except: [:show]  
  before_action :ensure_guest_user, only: [:edit]
  before_action :ensure_correct_user, only: [:edit, :update]

  def mypage
    @user = current_user
    @posts = @user.posts.order(created_at: :desc).page(params[:page]).per(16)
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.order(created_at: :desc).page(params[:page]).per(16)
  end  

  def edit
    @user = current_user
  end

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

  def destroy
    @user = current_user
    @user.destroy
    flash[:notice] = "アカウントを削除しました"
    redirect_to root_path
  end

  def feed
    @posts = current_user.feed.order(created_at: :desc)
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

  def ensure_correct_user
    @user = User.find(params[:id])
    unless @user == current_user
      flash[:alert] = "他のユーザーのプロフィールは編集できません。"
      redirect_to root_path
    end
  end

end

