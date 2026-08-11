class Project < ApplicationRecord
  has_one_attached :screenshot

  validates :title, presence: true
  validates :description, presence: true

  scope :featured, -> { where(featured: true).order(position: :asc) }
  scope :ordered, -> { order(position: :asc, created_at: :desc) }
end
