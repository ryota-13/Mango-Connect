class Public::SearchesController < ApplicationController
  before_action :authenticate_user!

  def search
    @model = params[:model] || 'user' 
    @content = params[:content]
    @method = params[:method] || 'partial' 

    if @model == "user"
      @records = User.search_for(@content, @method)
    elsif @model == "post"
      @records = Post.search_for(@content, @method)
    else
      @records = [] 
    end
  end
end

