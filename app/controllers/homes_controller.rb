class HomesController < ApplicationController
  
  def top
    @posts = Post.all # 投稿一覧を取得
  end

  def about
  end
end
