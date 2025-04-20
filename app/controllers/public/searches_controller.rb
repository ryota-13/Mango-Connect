class Public::SearchesController < ApplicationController
  before_action :authenticate_user!

  def search
    @model = params[:model] || 'user' 
    @content = params[:content]
    @method = params[:method] || 'partial' 

    if @model == "user"
      @records = User.search_for(@content, @method).page(params[:page]).per(10)
    elsif @model == "post"
      @records = Post.search_for(@content, @method).page(params[:page]).per(10)
    else
      @records = [] 
    end
  end
end

