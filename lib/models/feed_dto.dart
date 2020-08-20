import 'package:unfollow_app_flutter/models/Pictures_dto.dart';

class Feed {
  String nextPage;
  int size;
  List<Picture> pictures;

  Feed.fromJson(Map<String, dynamic> json) {
    this.nextPage = json['nextPage'];
    this.size = json['size'];
    this.pictures = List<Picture>.from(
        json['pictures'].map((picture) => Picture.fromJson(picture)));
  }
}
