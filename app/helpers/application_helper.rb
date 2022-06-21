module ApplicationHelper
  def published_date(article)
    article.published_date.strftime("%B %d, %l:%M %p")
  end
end
