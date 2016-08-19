class ArticlesController < ApplicationController

  def index
    @articles = Article.open.readable_for(current_member).order(released_at: :desc)
      .paginate(page: params[:page], per_page: 5)
  end

  def show
    @article = Article.open.readable_for(current_member).find(params[:id])
  end
end
