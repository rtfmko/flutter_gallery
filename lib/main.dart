import 'package:flutter/material.dart';
import 'package:fluttergallery/route_generator.dart';

void main() {runApp(GalleryApp());}

class GalleryApp extends StatefulWidget {
  @override
  _GalleryAppState createState() => _GalleryAppState();
}

class _GalleryAppState extends State<GalleryApp>{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      onGenerateRoute: RouteGenerator.generateRoute,
      theme: ThemeData.dark(),
    );
  }
}