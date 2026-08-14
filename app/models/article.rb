class Article < ApplicationRecord
  has_one_attached :cover_image
  has_many_attached :content_images

  validates :title, presence: true
  validates :body, presence: true
  validates :slug, presence: true, uniqueness: true

  scope :published, -> { where(published: true).order(published_at: :desc) }
  scope :recent, -> { published.limit(3) }
  scope :featured, -> { published.where(featured: true) }

  before_validation :generate_slug, on: :create

  def localized_title
    I18n.locale == :en && title_en.present? ? title_en : title
  end

  def localized_body
    I18n.locale == :en && body_en.present? ? body_en : body
  end

  def localized_excerpt
    I18n.locale == :en && excerpt_en.present? ? excerpt_en : excerpt
  end

  def localized_slug
    I18n.locale == :en && slug_en.present? ? slug_en : slug
  end

  def reading_time
    words_per_minute = 200
    words = localized_body.to_s.split.size
    (words / words_per_minute.to_f).ceil
  end

  def formatted_date
    return "" unless published_at
    if I18n.locale == :en
      published_at.strftime("%B %d, %Y")
    else
      published_at.strftime("%d de %B de %Y")
    end
  end

  private

  def generate_slug
    self.slug = title.to_s.parameterize if slug.blank?
    self.slug_en = (title_en.present? ? title_en : title).to_s.parameterize if slug_en.blank?
  end
end
