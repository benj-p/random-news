class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
    @article = Article.where('published_date > ?', 24.hours.ago).order(published_date: :desc).first
  end
end
