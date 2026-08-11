class CreateProjects < ActiveRecord::Migration[7.1]
  def change
    create_table :projects do |t|
      t.string :title, null: false
      t.text :description, null: false
      t.string :technologies
      t.string :live_url
      t.string :github_url
      t.boolean :featured, default: false
      t.integer :position, default: 0

      t.timestamps
    end

    add_index :projects, :featured
    add_index :projects, :position
  end
end
