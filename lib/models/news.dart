class News {

  String author;
  String title;
  String description;
  String url;
  String urlToImage;
  String publishedAt;

  News({this.author, this.title, this.description, this.url, this.urlToImage, this.publishedAt});

  factory News.fromJson(Map<String, dynamic> json) {
    return News(
      author: json['author'],
      title: json['title'],
      description: json['description'],
      url: json['url'],
      urlToImage: json['urlToImage'],
      publishedAt: json['publishedAt'],
    );
  }





}