import 'package:fpic_app/data/photo.dart';
import 'package:fpic_app/data/video.dart';
import 'package:fpic_app/data/document.dart';

class MenuPage {
  final String title_en;
  final String title_kh;
  final String body_en;
  final String body_kh;
  final List<Video>? videos;
  final List<Document>? documents_en;
  final List<Document>? documents_kh;
  final List<Photo>? photos;
  final String image;

  MenuPage(this.title_en, this.title_kh, this.image, this.body_en, this.body_kh,
      this.documents_en, this.documents_kh, this.videos, this.photos);

  MenuPage.fromJson(Map<String, dynamic> json)
      : title_en = json['title_en'],
        title_kh = json['title_kh'],
        body_en = json['body_en'],
        body_kh = json['body_kh'],
        videos = json['videos'] != null
            ? (json['videos'] as List).map((i) => Video.fromJson(i)).toList()
            : null,
        documents_en = json['documents_en'] != null
            ? (json['documents_en'] as List)
                .map((i) => Document.fromJson(i))
                .toList()
            : null,
        documents_kh = json['documents_kh'] != null
            ? (json['documents_kh'] as List)
                .map((i) => Document.fromJson(i))
                .toList()
            : null,
        photos = json['photos'] != null
            ? (json['photos'] as List).map((i) => Photo.fromJson(i)).toList()
            : null,
        image = json['image'] ?? "";
}
