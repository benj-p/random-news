class ArticlesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]
  
  def index
    age_hours = params[:age_hours] || nil
    
    articles = Article.all
    articles = Article.where('published_date > ?', age_hours.to_i.hours.ago) if age_hours

    render json: { articles: articles.as_json(methods: :short_body) } 
  end
end