import 'package:date_format/date_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttergallery/models/picture.dart';

class PagePhotoInfo extends StatelessWidget{
  final Picture picture;
  final String quality;

  PagePhotoInfo({
    @required this.picture,
    @required this.quality,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onDoubleTap: () {
        Navigator.of(context).pop();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("Details"),
        ),
        body: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(10),
              child: Row(
                children: <Widget>[
                  Icon(Icons.calendar_today),
                  SizedBox(width: 10,),
                  Text(
                    picture.createdAt != null
                        ? formatDate(picture.createdAt, [
                      dd, ' ', mm, ' ', yyyy, ' ',
                      HH, ':', nn,
                    ]) : "No date" ,
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: Row(
                children: <Widget>[
                  Icon(Icons.image),
                  SizedBox(width: 10,),
                  Text("Image Information"),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("Description:"),
                  SizedBox(height: 5,),
                  Text(picture.description == null
                      ? "No Description"
                      : picture.description),
                  SizedBox(height: 20,),
                  Text("Alt Description:"),
                  SizedBox(height: 5,),
                  Text(picture.altDescription == null
                      ? "No Alt Description"
                      : picture.altDescription),
                  SizedBox(height: 20,),
                  Text("Author:"),
                  SizedBox(height: 5,),
                  Text(picture.user.userName == null
                      ? "No user name"
                      : picture.user.userName),
                  SizedBox(height: 5,),
                  Text("${picture.user.firstName == null
                      ? "No first name"
                      : picture.user.firstName} "
                      "${picture.user.lastName == null
                      ? "No last name"
                      : picture.user.lastName}"),
                  SizedBox(height: 20,),
                  Text("Resolution:"),
                  SizedBox(height: 5,),
                  Text(picture.height | picture.width != null
                      ? "${picture.height}x${picture.width}"
                      : "No resolution information"
                  ),
                  SizedBox(height: 20,),
                  Text("Quality:"),
                  SizedBox(height: 5,),
                  Text("$quality"),
                  SizedBox(height: 20,),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      children: <Widget>[
                        Icon(Icons.camera_alt),
                        SizedBox(width: 10,),
                        Text("Camera Information"),
                      ],
                    ),
                  ),
                  Text("${picture.info.makeOn == null
                      ? "No camera information"
                      : picture.info.makeOn}   "
                      "${picture.info.model == null
                      ? "No model information"
                      : picture.info.model}"),
                  SizedBox(height: 5,),
                  Text("F${picture.info.aperture == null
                      ? "No aperture information"
                      : picture.info.aperture}   "
                      "${picture.info.exposureTime == null
                      ? "No exposure information"
                      : picture.info.exposureTime}mm   "
                      "${picture.info.focalLength == null
                      ? "No focal length information"
                      : picture.info.focalLength}    "
                      "ISO ${picture.info.iso == null
                      ? "No iso information"
                      : picture.info.iso}"),
                  SizedBox(height: 20,),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}