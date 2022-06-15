require 'open-uri'

class TheConversation
  def update_db
    get_articles.each do |article|
      Article.create(article.merge({source: 'The Conversation'}))
    end
  end

  def get_articles
    url = "https://theconversation.com/global"
    html_file = URI.open(url)
    html_doc = Nokogiri::HTML(html_file)

    articles = []

    html_doc.search('article').each do |article|
      article_data = {
        url: "https://theconversation.com/" + article.at('.article--header a')['href'],
        title: article.at('.article--header a').text.strip,
        article_source_id: article['data-id']
      }
      article_data.merge!(get_article_date_and_body(article_data[:url]))
      articles << article_data
    end

    articles
  end

  def get_article_date_and_body(url)
    html_file = URI.open(url)
    html_doc = Nokogiri::HTML(html_file)

    {
      body: get_article_body(html_doc),
      published_date: get_article_date(html_doc)
    }
  end

  def get_article_date(html_doc)
    html_doc.at('time')['datetime'].to_datetime
  end

  def get_article_body(html_doc)
    article_html = []
    html_doc.search('[itemprop="articleBody"] > p, [itemprop="articleBody"] > h2').each do |el|
      article_html << el.to_s unless el.text.strip.empty?
    end

    article_html.join
  end
end