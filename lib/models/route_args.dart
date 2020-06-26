import 'package:flutter/material.dart';
import 'package:fluttergallery/models/picture.dart';

class RouteArgs {
  Picture picture;
  GlobalKey<ScaffoldState> scaffoldKey;
  int count;
  String apiKey;
  String quality;

  RouteArgs({
    this.picture,
    this.scaffoldKey,
    this.count,
    this.apiKey,
    this.quality,
  });
}