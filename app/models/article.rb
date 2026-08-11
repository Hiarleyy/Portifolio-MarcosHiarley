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

  def reading_time
    words_per_minute = 200
    words = body.to_s.split.size
    (words / words_per_minute.to_f).ceil
  end

  def formatted_date
    published_at&.strftime("%d de %B de %Y")
  end

  private

  def generate_slug
    self.slug = title.to_s.parameterize if slug.blank?
  end
end
