class Project < ApplicationRecord
  has_one_attached :screenshot

  validates :title, presence: true
  validates :description, presence: true

  scope :featured, -> { where(featured: true).order(position: :asc) }
  scope :ordered, -> { order(position: :asc, created_at: :desc) }

  def localized_title
    I18n.locale == :en && title_en.present? ? title_en : title
  end

  def localized_description
    I18n.locale == :en && description_en.present? ? description_en : description
  end
end
