module Public
 class Public::HomesController  < ApplicationController
    
    def top
      if params[:latest]
        @posts = Post.latest.page(params[:page]).per(16)
      elsif params[:old]
        @posts = Post.old.page(params[:page]).per(16)
      elsif params[:most_favorited]
        @posts = Post.most_favorited.page(params[:page]).per(16)
      else
        @posts = Post.latest.page(params[:page]).per(16)
      end
    end

    def about
    end
  end
end
