class Public::CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @post = Post.find(params[:post_id])
    @comment = current_user.comments.new(comment_params)
    @comment.post = @post
  
    if @comment.save
      redirect_to post_path(@post)
    else
      @comments = @post.comments.includes(:user)
      render 'public/posts/show'
    end
  end
  

  def destroy
    comment = Comment.find(params[:id])
    if comment.user == current_user
      comment.destroy
    end
    redirect_to post_path(comment.post)
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end
end
