const localSessionKey = "history.history"

import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = [ "newsContainer", "readMoreButton", "refreshButton", "articleTitle", "articleBody", "loader", "allRead" ]
  
  async refresh(event) {
    event.preventDefault()
    window.scrollTo({ top: 0, behavior: 'smooth' })
    this.loaderTarget.classList.remove('inactive')
    this.articleTitleTarget.innerHTML = null
    this.articleBodyTarget.innerHTML = null  

    let searchParams = this.setSearchParams()
    const data = await fetch(`/articles?${searchParams}`).then((response) => response.json())
    const timerDuration = Math.floor((Math.random() * 1000) + 200)
    
    if (data["articles"].length === 0) {
      setTimeout(() => {
        this.loaderTarget.classList.add('inactive')
        this.allReadTarget.classList.remove('inactive')
        this.readMoreButtonTarget.style.pointerEvents = "none";
        this.refreshButtonTarget.style.pointerEvents = "none";
      }, timerDuration);      
    } else {
      let article = data["articles"][data["articles"].length * Math.random() | 0]
      this.updateHistory(article["id"])
      setTimeout(() => {
        this.loaderTarget.classList.add('inactive')
        this.updateContent(article)
      }, timerDuration);
    }

  }

  setSearchParams() {
    let searchParams = new URLSearchParams()
    searchParams.set("age_hours", 12)
    this.history.forEach((id) => {
      searchParams.append("history[]", id)
    });
    return searchParams.toString()
  }

  setHistory() {
    let historyValue = window.sessionStorage.getItem(localSessionKey)
    this.history = JSON.parse(historyValue)
  }

  updateHistory(id) {
    this.setHistory()
    this.history.push(id)
    window.sessionStorage.setItem(localSessionKey, JSON.stringify(this.history))
  }

  updateContent(article) {
    this.articleTitleTarget.innerHTML = article["title"]
    this.articleBodyTarget.innerHTML = article["short_body"]
    this.newsContainerTarget.dataset.id = article["id"]
    this.readMoreButtonTarget.href = article["url"]
  }

  connect() {
    this.history = [parseInt(this.newsContainerTarget.dataset.id)]
    window.sessionStorage.setItem(localSessionKey, JSON.stringify(this.history))
  }
}