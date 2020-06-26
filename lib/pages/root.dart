import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttergallery/json_dao/load_data_dao.dart';
import 'package:fluttergallery/models/picture.dart';
import 'package:fluttergallery/models/route_args.dart';

class PageRoot extends StatefulWidget{
  @override
  _PageRootState createState() => _PageRootState();
}

class _PageRootState extends State<PageRoot>{
  String _apiKey, _quality;
  int _count, _loadItem, _columnCount;
  bool _isUpdate;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  Future<List<Picture>> _listPictures;

  @override
  void initState() {
    super.initState();
    _apiKey = "cf49c08b444ff4cb9e4d126b7e9f7513ba1ee58de7906e4360afc1a33d1bf4c0";
    _quality = "Regular";
    _isUpdate = false;
    _columnCount = 3;
    _count = 1;
    _loadItem = 4;
    _load();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: GestureDetector(
        onLongPress: () {
          _isUpdate = true;
          _load();
        },
        child: Scaffold(
          key: _scaffoldKey,
          appBar: AppBar(
            title: Text("Gallery"),
            actions: <Widget>[
              IconButton(
                  icon: Icon(Icons.view_comfy),
                  onPressed: (){
                    _gridSettings();
                  }),
              IconButton(
                  icon: Icon(Icons.settings),
                  onPressed: (){
                    _settings().whenComplete(() => _load());
                  }),
            ],
          ),
          body: FutureBuilder(
            future: Future.sync(() => _listPictures),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                case ConnectionState.waiting:
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                case ConnectionState.active:
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                case ConnectionState.done:
                  List<Picture> pic = snapshot.data;
                  if(pic==null){
                    return Container(
                      child: Center(
                        child: Text("Error while taking response from server"
                            "\nTry change API-key in Settings"),
                      ),
                    );
                  }
                  return GridView.count(
                    padding: EdgeInsets.all(5),
                    mainAxisSpacing: 6,
                    crossAxisCount: _columnCount,
                    crossAxisSpacing: 5,
                    children: List.generate(pic.length, (index) {
                      return Hero(
                        tag: "${pic[index].id} $index",
                        child: InkWell(
                          onTap: (){
                            RouteArgs routeArgs = RouteArgs(
                              picture: pic[index],
                              scaffoldKey: _scaffoldKey,
                              quality: _quality,
                            );
                            Navigator.pushNamed(context, "/showPhoto/",
                                arguments: routeArgs);
                          },
                          child: Stack(
                            overflow: Overflow.clip,
                            children: <Widget>[
                              Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage(pic[index].urls.thumb),
                                    fit: BoxFit.fill,
                                  ),
                                  shape: BoxShape.rectangle,
                                ),
                              ),
                              Container(
                                height: 110.0,
                                width: 110.0,
                                child: Text("${pic[index].user.userName}",
                                  style: TextStyle(
                                      foreground: Paint()
                                        ..color=Colors.white
                                        ..strokeWidth = 1
                                        ..style = PaintingStyle.stroke
                                  ),),
                              ),
                              Container(
                                padding: EdgeInsets.all(5.0),
                                alignment: Alignment.bottomCenter,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: <Color>[
                                      Colors.black.withAlpha(0),
                                      Colors.black12,
                                      Colors.black45
                                    ],
                                  ),
                                ),
                                child: Text("${pic[index].description==null
                                    ? "No Description"
                                    : "${pic[index].description.length >= 10
                                    ? "${pic[index].description.substring(0,10)}..."
                                    : pic[index].description}" }",
                                  style: TextStyle(
                                      foreground: Paint()
                                        ..color=Colors.white
                                        ..strokeWidth = 1
                                        ..style = PaintingStyle.stroke
                                  ),),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
                  );
                default:
                  return Center(
                    child: CircularProgressIndicator(),
                  );
              }
            },
          ),
        ),
      ),
    );
  }

  Future _gridSettings() {
    return showGeneralDialog(
      barrierLabel: 'gridSettings',
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: Duration(milliseconds: 250),
      context: _scaffoldKey.currentContext,
      transitionBuilder: (context, anim1, anim2, child) {
        return SlideTransition(
          position: Tween(
              begin: Offset(0, -1),
              end: Offset(0, 0)).animate(anim1),
          child: child,
        );
      },
      pageBuilder: (context, anim1, anim2) => AlertDialog(
        contentPadding: EdgeInsets.all(25.0),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0))
        ),
        content: Container(
          height: 100,
          child: ListTile(
            title: Text("Grid Settings"),
            subtitle: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text("Grid column"),
                    FlatButton(
                        color: Colors.transparent,
                        child: Text("$_columnCount"),
                        onPressed: (){
                          showModalBottomSheet(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                              side: BorderSide(
                                  color: Theme.of(context).primaryColor),
                            ),
                            isScrollControlled: false,
                            barrierColor: Colors.black.withOpacity(0.5),
                            context: _scaffoldKey.currentContext,
                            builder: (BuildContext context) {
                              return Container(
                                padding: EdgeInsets.symmetric(vertical: 8),
                                margin: EdgeInsets.symmetric(horizontal: 4),
                                height: 200,
                                width: 50,
                                child: ListView.builder(
                                  itemCount: 5,
                                  itemBuilder: (BuildContext context, int index) {
                                    return RaisedButton(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(18.0),
                                        side: BorderSide(
                                            color: Theme.of(context).primaryColor),
                                      ),
                                      child: Text("${index+1}"),
                                      onPressed: (){
                                        setState(() {
                                          _columnCount = index+1;
                                          Navigator.pop(context);
                                        });
                                      },
                                    );
                                  },
                                ),
                              );
                            },
                          ).whenComplete(() => Navigator.pop(context));
                        }),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    FlatButton(
                      child: Text('Back'),
                      onPressed: () => Navigator.of(context).pop(),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future _settings(){
    final List<String> _apiKeys = [
      "cf49c08b444ff4cb9e4d126b7e9f7513ba1ee58de7906e4360afc1a33d1bf4c0",
      "ab3411e4ac868c2646c0ed488dfd919ef612b04c264f3374c97fff98ed253dc9",
      "896d4f52c589547b2134bd75ed48742db637fa51810b49b607e37e46ab2c0043",
    ];

    final List<String> _qualityList = [
      "Raw",
      "Full",
      "Regular",
    ];

    return showGeneralDialog(
      barrierLabel: 'gallerySettings',
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: Duration(milliseconds: 250),
      context: _scaffoldKey.currentContext,
      transitionBuilder: (context, anim1, anim2, child) {
        return SlideTransition(
          position: Tween(
              begin: Offset(0, -1),
              end: Offset(0, 0)).animate(anim1),
          child: child,
        );
      },
      pageBuilder: (context, anim1, anim2) => AlertDialog(
        contentPadding: EdgeInsets.all(25.0),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0))
        ),
        content: Container(
          height: 300,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(left: 20, top: 10),
                child: Text("Select API key", style: TextStyle(
                  fontSize: 22, fontWeight: FontWeight.bold,),),
              ),
              Container(
                padding: EdgeInsets.only(left: 20, top: 10),
                child: Row(
                  children: <Widget>[
                    Text("API key select"),
                    FlatButton(
                        color: Colors.transparent,
                        child: Text("$_count"),
                        onPressed: (){
                          showModalBottomSheet(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                              side: BorderSide(
                                  color: Theme.of(context).primaryColor),
                            ),
                            isScrollControlled: false,
                            barrierColor: Colors.black.withOpacity(0.5),
                            context: _scaffoldKey.currentContext,
                            builder: (BuildContext context) {
                              return Container(
                                padding: EdgeInsets.symmetric(vertical: 8),
                                margin: EdgeInsets.symmetric(horizontal: 4),
                                height: 200,
                                width: 50,
                                child: ListView.builder(
                                  itemCount: _apiKeys.length,
                                  itemBuilder: (BuildContext context, int index) {
                                    return RaisedButton(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(18.0),
                                        side: BorderSide(
                                            color: Theme.of(context).primaryColor),
                                      ),
                                      child: Text("API Key ${index+1} "
                                          "${_apiKeys[index].substring(0,5)}"),
                                      onPressed: (){
                                        setState(() {
                                          _apiKey = _apiKeys[index];
                                          _count = index+1;
                                          _isUpdate = true;
                                        });
                                        Navigator.of(context).pop();
                                      },
                                    );
                                  },
                                ),
                              );
                            },
                          ).whenComplete(() => Navigator.of(context).pop());
                        }),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 20, top: 10),
                child: Text("Select items to load", style: TextStyle(
                  fontSize: 22, fontWeight: FontWeight.bold,),),
              ),
              Container(
                padding: EdgeInsets.only(left: 20, top: 10),
                child: Row(
                  children: <Widget>[
                    Text("Count items to load"),
                    FlatButton(
                        color: Colors.transparent,
                        child: Text("${_loadItem+1}"),
                        onPressed: (){
                          showModalBottomSheet(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                              side: BorderSide(
                                  color: Theme.of(context).primaryColor),
                            ),
                            isScrollControlled: false,
                            barrierColor: Colors.black.withOpacity(0.5),
                            context: _scaffoldKey.currentContext,
                            builder: (BuildContext context) {
                              return Container(
                                padding: EdgeInsets.symmetric(vertical: 8),
                                margin: EdgeInsets.symmetric(horizontal: 4),
                                height: 200,
                                width: 50,
                                child: ListView.builder(
                                  itemCount: 20,
                                  itemBuilder: (BuildContext context, int index) {
                                    return RaisedButton(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(18.0),
                                        side: BorderSide(
                                            color: Theme.of(context).primaryColor),
                                      ),
                                      child: Text("${index+1}"),
                                      onPressed: (){
                                        setState(() {
                                          _loadItem = index;
                                          _isUpdate = true;
                                        });
                                        Navigator.of(context).pop();
                                      },
                                    );
                                  },
                                ),
                              );
                            },
                          ).whenComplete(() => Navigator.of(context).pop());
                        }),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 20, top: 10),
                child: Text("Select quality of images", style: TextStyle(
                  fontSize: 22, fontWeight: FontWeight.bold,),),
              ),
              Container(
                padding: EdgeInsets.only(left: 20, top: 10),
                child: Row(
                  children: <Widget>[
                    Text("Quality of image"),
                    FlatButton(
                        color: Colors.transparent,
                        child: Text("$_quality"),
                        onPressed: (){
                          showModalBottomSheet(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                              side: BorderSide(
                                  color: Theme.of(context).primaryColor),
                            ),
                            isScrollControlled: false,
                            barrierColor: Colors.black.withOpacity(0.5),
                            context: _scaffoldKey.currentContext,
                            builder: (BuildContext context) {
                              return Container(
                                padding: EdgeInsets.symmetric(vertical: 8),
                                margin: EdgeInsets.symmetric(horizontal: 4),
                                height: 200,
                                width: 50,
                                child: ListView.builder(
                                  itemCount: _qualityList.length,
                                  itemBuilder: (BuildContext context, int index) {
                                    return RaisedButton(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(18.0),
                                        side: BorderSide(
                                            color: Theme.of(context).primaryColor),
                                      ),
                                      child: Text("${_qualityList[index]} "
                                          "${_qualityList[index] != "Regular"
                                          ? "" : "(recommended)"}"),
                                      onPressed: (){
                                        setState(() {
                                          _quality = _qualityList[index];
                                          _isUpdate = false;
                                        });
                                        Navigator.of(context).pop();
                                      },
                                    );
                                  },
                                ),
                              );
                            },
                          ).whenComplete(() => Navigator.of(context).pop());
                        }),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _load(){
   if(_isUpdate){
     setState(() {
       _listPictures = LoadDataDAO().fetchAlbum(_apiKey, _loadItem);
       _isUpdate = false;
     });
   }
  }
}