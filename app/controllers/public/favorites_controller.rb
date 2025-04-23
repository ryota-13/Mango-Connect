class Public::FavoritesController < ApplicationController
  before_action :authenticate_user!

  def create
    @post = Post.find(params[:post_id])
    favorite = current_user.favorites.new(post: @post)
    favorite.save
    respond_to do |format|
      format.js
    end
  end
  
  def destroy
    @post = Post.find(params[:post_id])
    favorite = current_user.favorites.find_by(post: @post)
    favorite.destroy if favorite
    respond_to do |format|
      format.js
    end
  end  

  def index
    @favorites = current_user.favorited_posts.order(created_at: :desc).page(params[:page]).per(16)
  end  
end
