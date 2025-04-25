class Admin::CommentsController < ApplicationController
  before_action :authenticate_admin!

  def destroy
    post = Post.find(params[:post_id])
    comment = post.comments.find(params[:id])
    comment.destroy
    flash[:notice] = "コメントを削除しました"
    redirect_to admin_post_path(post)
  end
end
