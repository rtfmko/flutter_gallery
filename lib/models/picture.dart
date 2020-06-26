import 'package:fluttergallery/models/info.dart';
import 'package:fluttergallery/models/urls.dart';
import 'package:fluttergallery/models/user.dart';

class Picture{
  String id;
  DateTime createdAt;
  DateTime updatedAt;
  DateTime promotedAt;
  int width;
  int height;
  String description;
  String altDescription;
  Urls urls;
  Info info;
  User user;
  int likes;
  int views;

  Picture({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.promotedAt,
    this.width,
    this.height,
    this.description,
    this.altDescription,
    this.urls,
    this.info,
    this.user,
    this.likes,
    this.views,
  });

  factory Picture.fromMap(Map<String, dynamic> json) => Picture(
    id: json['id'],
    createdAt: json['created_at'] != null
        ? DateTime.parse(json["created_at"])
        : null,
    updatedAt: json['updated_at'] != null
        ? DateTime.parse(json["updated_at"])
        : null,
    promotedAt: json['promoted_at'] != null
        ? DateTime.parse(json["promoted_at"])
        : null,
    width: json['width'],
    height: json['height'],
    description: json['description'],
    altDescription: json['alt_description'],
    urls: Urls.fromMap(json['urls']),
    user: User.fromMap(json['user']),
    info: Info.fromMap(json['exif']),
    likes: json['likes'],
    views: json['views'],
  );
}