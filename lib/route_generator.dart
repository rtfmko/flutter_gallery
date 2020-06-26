import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttergallery/models/route_args.dart';
import 'package:fluttergallery/pages/photo_info.dart';
import 'package:fluttergallery/pages/root.dart';
import 'package:fluttergallery/pages/show_photo.dart';

class RouteGenerator{
  static Route<dynamic> generateRoute(RouteSettings routeSettings){

    final args = routeSettings.arguments;

    switch (routeSettings.name){
      case '/':
        return MaterialPageRoute(builder: (_) => PageRoot());
      case '/showPhoto/':
        if(args is RouteArgs) {
          return MaterialPageRoute(builder: (_) => PageShowPhoto(
            picture: args.picture,
            scaffoldKey: args.scaffoldKey,
            quality: args.quality,
          ));
        }
        return _errorRoute(routeSettings.name);
      case '/photoInfo/':
        if(args is RouteArgs) {
          return MaterialPageRoute(builder: (_) => PagePhotoInfo(
            picture: args.picture,
            quality: args.quality,
          ));
        }
        return _errorRoute(routeSettings.name);
      default:
        return _errorRoute(routeSettings.name);
    }

  }

  static Route<dynamic> _errorRoute(String route) {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Error'),
        ),
        body: Center(
          child: Text('ERROR route: $route)'),
        ),
      );
    });
  }
}