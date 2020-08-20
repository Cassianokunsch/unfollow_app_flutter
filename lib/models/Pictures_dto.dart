class Picture {
  String pk;
  int commentCount;
  int likeCount;
  String url;

  Picture.fromJson(Map<String, dynamic> json) {
    this.pk = json['pk'];
    this.commentCount = json['commentCount'];
    this.likeCount = json['likeCount'];
    this.url = json['url'];
  }
}
