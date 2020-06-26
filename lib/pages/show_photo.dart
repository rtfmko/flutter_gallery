import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttergallery/models/picture.dart';
import 'package:fluttergallery/models/route_args.dart';

class PageShowPhoto extends StatelessWidget {
  final Picture picture;
  final String quality;
  final GlobalKey<ScaffoldState> scaffoldKey;

  PageShowPhoto({
    @required this.picture,
    @required this.scaffoldKey,
    @required this.quality,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onVerticalDragStart: (dragDetails) {
        RouteArgs routeArgs = RouteArgs(
            picture: picture,
            quality: quality
        );
        Navigator.pushNamed(context, "/photoInfo/",
            arguments: routeArgs);
      },
      onDoubleTap: () {
        Navigator.pop(context);
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image(image: _getImageWithQuality(),),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Icon(Icons.favorite),
                    Text("${picture.likes != null
                        ? picture.likes
                        : "0"}"
                    ),
                  ],
                ),
                Column(
                  children: <Widget>[
                    Icon(Icons.remove_red_eye),
                    Text("${picture.views != null
                        ? picture.views
                        : "0"}"
                    ),
                  ],
                ),
              ],)
          ],
        ),
      ),
    );
  }

  NetworkImage _getImageWithQuality(){
    switch (quality){
      case "Full":
        return NetworkImage(picture.urls.full,);
      case "Regular":
        return NetworkImage(picture.urls.regular,);
      case "Raw":
        return NetworkImage(picture.urls.raw,);
      default:
        return NetworkImage(picture.urls.raw,);
    }
  }
}