class CreateArticles < ActiveRecord::Migration[7.0]
  def change
    create_table :articles do |t|
      t.string :source
      t.string :url
      t.string :title
      t.text :body
      t.string :article_source_id

      t.timestamps
    end
  end
end
