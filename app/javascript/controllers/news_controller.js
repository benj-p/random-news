import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = [ "newsContainer", "readMoreButton", "articleTitle", "articleBody", "loader" ]
  
  refresh(event) {
    event.preventDefault()
    window.scrollTo({ top: 0, behavior: 'smooth' });
    this.loaderTarget.classList.remove('inactive')
    this.articleTitleTarget.innerHTML = null
    this.articleBodyTarget.innerHTML = null  
    const timerDuration = Math.floor((Math.random() * 1000) + 200);
    setTimeout(() => {  
      this.getArticle();
      this.loaderTarget.classList.add('inactive') }, timerDuration);
  }

  updateContent(article) {
    this.articleTitleTarget.innerHTML = article["title"]
    this.articleBodyTarget.innerHTML = article["short_body"]
    this.newsContainerTarget.dataset.id = article["id"]
    this.readMoreButtonTarget.href = article["url"]
  }

  getArticle() {
    fetch('/articles?age_hours=24')
    .then((response) => response.json())
    .then((data) => {
        const article = data["articles"][data["articles"].length * Math.random() | 0]
        this.updateContent(article)
    });
  }
}