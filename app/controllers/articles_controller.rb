class ArticlesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]
  
  def index
    age_hours = params[:age_hours] || nil
    history = params[:history] || nil
    
    articles = Article.all
    articles = Article.where('published_date > ?', age_hours.to_i.hours.ago) if age_hours
    articles = articles.where.not(id: params[:history]) if history

    render json: { articles: articles.as_json(methods: :short_body) } 
  end
end