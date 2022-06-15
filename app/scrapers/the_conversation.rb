require 'open-uri'

class TheConversation
  def get_articles
    url = "https://theconversation.com/global"
    html_file = URI.open(url)
    html_doc = Nokogiri::HTML(html_file)

    articles = []

    html_doc.search('article').each_with_object({}) do |article, article_data|
      article_data[:url] = "https://theconversation.com/" + article.at('.article--header a')['href']
      article_data[:headline] = article.at('.article--header a').text.strip
      article_data[:article_id] = article['data-id'].to_i
      article_data[:content] = get_article_content(article_data[:url])

      articles << article_data
    end

    articles
  end

  def get_article_content(url)
    html_file = URI.open(url)
    html_doc = Nokogiri::HTML(html_file)

    article_html = []
    html_doc.search('[itemprop="articleBody"] > p, [itemprop="articleBody"] > h2').each do |el|
      article_html << el.to_s unless el.text.strip.empty?
    end

    article_html.join
  end
end