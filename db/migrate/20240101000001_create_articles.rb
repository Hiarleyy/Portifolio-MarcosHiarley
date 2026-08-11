class CreateArticles < ActiveRecord::Migration[7.1]
  def change
    create_table :articles do |t|
      t.string :title, null: false
      t.text :body, null: false
      t.text :excerpt
      t.string :slug, null: false
      t.boolean :published, default: false
      t.boolean :featured, default: false
      t.datetime :published_at

      t.timestamps
    end

    add_index :articles, :slug, unique: true
    add_index :articles, :published
    add_index :articles, :published_at
  end
end
