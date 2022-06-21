class Article < ApplicationRecord
  validates :source, :url, :title, :body, :article_source_id, :published_date, presence: true
  validates :article_source_id, uniqueness: { scope: :source, message: "article already exists" }

  def short_body
    body.truncate(800, separator: /<\/p>/)
  end
end