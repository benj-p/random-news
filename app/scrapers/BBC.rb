require 'open-uri'

class BBC
  def update_db
    get_articles.each do |article|
      Article.create(article.merge({source: 'BBC'}))
    end
  end

  def get_articles
    url = "https://www.bbc.com/news"
    html_file = URI.open(url)
    html_doc = Nokogiri::HTML(html_file)

    articles = []

    top_story_rel_urls = html_doc.at('.nw-c-top-stories--international').to_s.scan(/\/news\/[\w-]+-\d+/)
    top_story_rel_urls.each do |rel_url|
      article_data = {
        url: "https://www.bbc.com#{rel_url}",
      }
      article_data.merge!(get_article_data(article_data[:url]))
      articles << article_data
    end

    articles
  end

  def get_article_data(url)
    html_file = URI.open(url)
    html_doc = Nokogiri::HTML(html_file)

    {
      article_source_id: url.match(/-(\d+)\z/)[1],
      published_date: html_doc.at('time')['datetime'].to_datetime,
      title: html_doc.at('#main-heading').text,
      body: get_article_body(html_doc)
    }
  end

  def get_article_body(html_doc)
    article_html = []

    html_doc.search('[data-component="text-block"] p').each do |el|
      article_html << el.to_s unless el.text.strip.empty?
      # TODO : Clean classes in body
    end

    article_html.join
  end
end