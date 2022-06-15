import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = [ "newsContainer", "readMoreButton", "articleTitle", "articleBody" ]
  
  refresh(event) {
    event.preventDefault()
    window.scrollTo({ top: 0, behavior: 'smooth' });
    this.getArticle();
  }

  updateContent(article) {
    this.articleTitleTarget.innerHTML = article["title"]
    this.articleBodyTarget.innerHTML = article["short_body"]
    this.newsContainerTarget.dataset.id = article["id"]
    this.readMoreButtonTarget.href = article["url"]
  }

  getArticle() {
    fetch('/articles')
    .then((response) => response.json())
    .then((data) => {
        const article = data["articles"][data["articles"].length * Math.random() | 0]
        this.updateContent(article)
    });
  }
}