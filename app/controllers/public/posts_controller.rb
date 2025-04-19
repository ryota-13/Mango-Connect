module Public
  class Public::PostsController < ApplicationController
    before_action :authenticate_user!

    def new
      @post = Post.new
    end

    def index
      redirect_to root_path
    end    

    def create
      @post = current_user.posts.build(post_params)
      if @post.save
        flash[:notice] = "投稿に成功しました"
        redirect_to root_path
      else
        flash.now[:alert] = "投稿に失敗しました"
        render :new
      end
    end    

    def show
      @post = Post.find(params[:id])
      @comment ||= Comment.new  
    end

    def edit
      @post = Post.find(params[:id])
      redirect_to root_path unless @post.user == current_user
    end

    def update
      @post = Post.find(params[:id])
      if @post.update(post_params)
        flash[:notice] = "投稿が更新されました"
        redirect_to post_path(@post)
      else
        flash.now[:notice] = "投稿の更新に失敗しました"
        render :edit
      end
    end

    def destroy
      @post = Post.find(params[:id])
      if @post.user == current_user
        @post.destroy
        redirect_to root_path, notice: '投稿が削除されました。'
      else
        flash[:alert] = "他のユーザーの投稿を削除することはできません。"
        redirect_to root_path
      end
    end

    private

    def post_params
      params.require(:post).permit(:title, :body, :image)
    end
  end
end
