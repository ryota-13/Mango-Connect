module Public
  class Public::PostsController < ApplicationController
    before_action :set_post, only: [:show, :edit, :update, :destroy]
    before_action :authenticate_user!, except: [:show]

    def new
      @post = Post.new
    end

    def create
      @post = current_user.posts.build(post_params)
      if @post.save
        redirect_to root_path, notice: '投稿が作成されました。'
      else
        render :new
      end
    end

    def show
    end

    def edit
      redirect_to root_path unless @post.user == current_user
    end

    def update
      if @post.update(post_params)
        redirect_to post_path(@post), notice: '投稿が更新されました。'
      else
        render :edit
      end
    end

    def destroy
      if @post.user == current_user
        @post.destroy
        redirect_to root_path, notice: '投稿が削除されました。'
      else
        redirect_to root_path
      end
    end

    private

    def set_post
      @post = Post.find(params[:id])
    end

    def post_params
      params.require(:post).permit(:title, :body, :image)
    end

  end
end