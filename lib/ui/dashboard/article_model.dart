class ArticleModel {
  int id;
  String title;
  String background;
  String createdAt;
  String content;

  ArticleModel({this.id, this.title, this.background, this.createdAt, this.content});

  factory ArticleModel.fromJSON(Map<String, dynamic> json) => ArticleModel(
    id: json["id"],
    title: json["title"],
    background: json["background"],
    createdAt: json["createdAt"],
    content: json["content"],
  );
}

class ListArticle {
  List<ArticleModel> listArticle;

  ListArticle({this.listArticle});

  factory ListArticle.fromJson(Map<String, dynamic> json) => ListArticle(
    listArticle: List<ArticleModel>.from(json["articles"].map((x) => ArticleModel.fromJSON(x)))
  );
}