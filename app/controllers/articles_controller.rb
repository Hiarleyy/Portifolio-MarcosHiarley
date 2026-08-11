class ArticlesController < ApplicationController
  def index
    @articles = Article.published.page(params[:page]).per(6)
  end

  def show
    @article = Article.published.find_by!(slug: params[:id])
    @related_articles = Article.published.where.not(id: @article.id).limit(3)
  end
end
