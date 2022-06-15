class Article < ApplicationRecord
  validates :source, :url, :title, :body, :article_source_id, presence: true
  validates :article_source_id, uniqueness: { scope: :source, message: "article already exists" }

  def short_body
    body.truncate(2000, separator: /<\/p>/)
  end
end