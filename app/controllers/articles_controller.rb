class ArticlesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]
  
  def index
    render json: { articles: Article.all.as_json(methods: :short_body) } 
  end
end