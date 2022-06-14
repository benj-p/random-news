import { Controller } from "@hotwired/stimulus";
import axios from 'axios';

export default class extends Controller {
  static targets = [ "newsContainer", "readMoreButton" ]
  
  refresh(event) {
    event.preventDefault()
    this.getNews();
  }

  getNews() {
    axios.get('https://newsapi.org/v2/everything?language=en&apiKey=a59c003a1c3f4c67b2c49fbdc5b492ea&q=barcelona&searchIn=title')
      .then(function (response) {
        const articles = response["data"]["articles"]
        const article = articles[articles.length * Math.random() | 0] 
        return article
      })
      .then((response) => {
        this.newsContainerTarget.innerHTML = response["description"]
        this.readMoreButtonTarget.href = response["url"]
      })
      .catch(function (error) {
        console.log(error);
      })
    }
    
  connect() {
    this.getNews();
  }
}