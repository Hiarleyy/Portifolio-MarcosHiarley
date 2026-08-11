class Admin::DashboardController < Admin::BaseController
  def index
    @articles_count = Article.count
    @published_articles_count = Article.published.count
    @projects_count = Project.count
    @recent_articles = Article.order(created_at: :desc).limit(5)
  end
end
