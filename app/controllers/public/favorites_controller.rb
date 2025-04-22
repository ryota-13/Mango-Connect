class Public::FavoritesController < ApplicationController
  before_action :authenticate_user!

  def create
    post = Post.find(params[:post_id])
    favorite = current_user.favorites.new(post: post)
    favorite.save
    redirect_back fallback_location: root_path
  end

  def destroy
    post = Post.find(params[:post_id])
    favorite = current_user.favorites.find_by(post: post)
    favorite.destroy if favorite
    redirect_back fallback_location: root_path
  end

  def index
    @favorites = current_user.favorited_posts
  end
end
