class CreateArticles < ActiveRecord::Migration[5.0]
  def change
    create_table :articles do |t|
      t.string :name
      t.string :description
      t.text :content
      t.string :image
      t.timestamps
    end
  end
end
