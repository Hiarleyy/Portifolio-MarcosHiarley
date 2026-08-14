class Admin::ArticlesController < Admin::BaseController
  before_action :set_article, only: [:edit, :update, :destroy]

  def index
    @articles = Article.order(created_at: :desc).page(params[:page]).per(10)
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    @article.published_at = Time.current if @article.published?

    if @article.save
      redirect_to admin_articles_path, notice: "Artigo criado com sucesso!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @article.published? && !@article.published_at
      @article.published_at = Time.current
    end

    if @article.update(article_params)
      redirect_to admin_articles_path, notice: "Artigo atualizado com sucesso!"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @article.cover_image.purge if @article.cover_image.attached?
    @article.content_images.purge if @article.content_images.attached?
    @article.destroy
    redirect_to admin_articles_path, notice: "Artigo removido com sucesso!"
  end

  private

  def set_article
    @article = Article.find(params[:id])
  end

  def article_params
    params.require(:article).permit(:title, :body, :excerpt, :slug, :title_en, :body_en, :excerpt_en, :slug_en, :published, :featured, :cover_image, content_images: [])
  end
end
