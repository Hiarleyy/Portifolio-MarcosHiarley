class AddEnglishFieldsToArticlesAndProjects < ActiveRecord::Migration[7.1]
  def change
    add_column :articles, :title_en, :string
    add_column :articles, :body_en, :text
    add_column :articles, :excerpt_en, :text
    add_column :articles, :slug_en, :string
    add_index :articles, :slug_en

    add_column :projects, :title_en, :string
    add_column :projects, :description_en, :text
  end
end
