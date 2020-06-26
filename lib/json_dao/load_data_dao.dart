import 'dart:convert';
import 'package:fluttergallery/models/picture.dart';
import 'package:http/http.dart' as http;

class LoadDataDAO{
  Future<List<Picture>> fetchAlbum(String apiKey, int count) async {
    List<Picture> _toReturn = [];
    var _response;

    for(int i = 0; i <= count; i++){
      _response =
          await http.get('https://api.unsplash.com/photos/random/?client_id='
              '$apiKey');
      if (_response.statusCode == 200) {
        _toReturn.add(Picture.fromMap(json.decode(_response.body)));
      } else {
        throw Exception('Failed to load album');
      }
    }
    return _toReturn;
  }
}