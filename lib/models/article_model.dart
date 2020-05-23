class ArticleModel {
  String author;
  String title;
  String description;
  String url;
  String urlToImage;
  String content;
  String publishedAt;
  ArticleModel(
      {this.description,
      this.title,
      this.author,
      this.content,
      this.url,
      this.urlToImage,
      this.publishedAt});
}
