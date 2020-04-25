import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:ui' as ui;
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:firebase_database/firebase_database.dart';
import 'home_page.dart';
import 'myData.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'profile_page2.dart';

class ShowDataPage extends StatefulWidget {
  @override
  _ShowDataPageState createState() => _ShowDataPageState();
}

class _ShowDataPageState extends State<ShowDataPage> {
  List<myData> allData = [];

  @override
  // ignore: must_call_super
  void initState() {
    FirebaseAuth.instance.currentUser().then((user) {
      fetchUser(user);
    });
  }

  fetchUser(FirebaseUser user) {
    DatabaseReference ref = FirebaseDatabase.instance.reference();
    ref
        .child('node-name')
        .orderByChild('id')
        .equalTo('${user.uid}')
        .once()
        .then((DataSnapshot snap) {
      var keys = snap.value.keys;
      var data = snap.value;
      print(snap.value.toString());
      allData.clear();
      for (var key in keys) {
        myData d = new myData(
          data[key]['name'],
          data[key]['number'],
          data[key]['address'],
          data[key]['id'],
          data[key]['location'],
          data[key]['website'],
        );
        allData.add(d);
      }
      setState(() {
        print('Length : ${allData.length}');
      });
    });
  }

  //Circular Image
  Positioned myImages(String images) {
    return Positioned(
      top: 0.0,
      left: 100.0,
      child: Container(
          width: 160.0,
          height: 160.0,
          decoration: new BoxDecoration(
              shape: BoxShape.circle,
              image: new DecorationImage(
                  fit: BoxFit.fill, image: new NetworkImage(images)))),
    );
  }

  _openURL() async {
    const url = 'https://robicrufarm.com/';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  //Edit Button
  Positioned editPage() {
    return Positioned(
      bottom: 30.0,
      left: 40.0,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: RaisedButton(
            color: Color(0xFF1D262D),
            child: new Text(
              "Edit",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => new ProfilePage()));
            },
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0))),
      ),
    );
  }

  //Center Widget
  Center profilePage(String name, String number, String location,
      String webLink, String address) {
    double cWidth = MediaQuery.of(context).size.width * 0.3;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          width: 300.0,
          height: 400.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.0),
            color: Color(0xffffffff),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 70.0),
                    child: Text(
                      name,
                      style: TextStyle(
                          color: new Color(0xFF1D262D),
                          fontWeight: FontWeight.bold,
                          fontSize: 24.0),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 8, 8, 8),
                        child: Text(
                          number,
                          style: TextStyle(
                              color: new Color(0xff335599), fontSize: 18.0),
                        ),
                      ),
                      Row(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.fromLTRB(8.0, 8, 0, 8),
                            child: Icon(FontAwesomeIcons.mapMarker,
                                color: Color(0xFF1D262D), size: 20.0),
                          ),
                          SizedBox(width: 10.0),
                          Container(
                            width: cWidth,
                            child: InkWell(
                              child: Text(
                                location,
                                style: TextStyle(
                                    color: new Color(0xff335599),
                                    fontSize: 20.0),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Icon(FontAwesomeIcons.link,
                          color: Color(0xFF1D262D), size: 20.0),
                      SizedBox(width: 10.0),
                      Container(
                        child: InkWell(
                          child: Text(
                            webLink,
                            style: TextStyle(
                                color: new Color(0xff335599), fontSize: 20.0),
                          ),
                          onTap: () {
                            _openURL();
                          },
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Container(
                        width: MediaQuery.of(context).size.width * 0.6,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 8, 8, 8),
                          child: Text(address,
                              style: TextStyle(
                                  color: new Color(0xff335599), fontSize: 18.0),
                              textAlign: TextAlign.center),
                        ),
                      ),
                    ],
                  ),
                  new Container(
                    width: 300,
                    height: 70,
                    decoration: new BoxDecoration(
                      shape: BoxShape.rectangle,
                      color: Color(0xff335599),
                    ),
                    child: Container(
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: new Text("Total No. of Aerators",
                                textAlign: TextAlign.center,
                                style: TextStyle(color: Colors.white)),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: new Text("03",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 25)),
                          )
                        ],
                      ),
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      new Container(
                        width: 150,
                        height: 70,
                        decoration: new BoxDecoration(
                          shape: BoxShape.rectangle,
                          color: Color(0xff335599),
                        ),
                        child: Container(
                          child: Column(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: new Text("No. of Aerators ON",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(color: Colors.white)),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: new Text("02",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 25)),
                              )
                            ],
                          ),
                        ),
                      ),
                      new Container(
                        width: 150,
                        height: 70,
                        decoration: new BoxDecoration(
                          shape: BoxShape.rectangle,
                          color: Color(0xff1D262D),
                        ),
                        child: Container(
                          child: Column(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: new Text("No. of Aerators OFF",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(color: Colors.white)),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: new Text("01",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 25)),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    initState();
    SizeConfig().init(context);
    return new Scaffold(
      body: Column(
        children: <Widget>[
          _myAppBar3(),
          Expanded(
            flex: 4,
            child: Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(color: Color(0xFFECF3FB)),
              child: CustomPaint(
                painter: CurvePainter(),
                child: allData.length == 0
                    ? new Text(
                        'No Data is Available',
                        style: TextStyle(color: Colors.white),
                      )
                    : new Stack(
                        children: <Widget>[
                          profilePage(
                              "${allData[0].name}",
                              "${allData[0].number}",
                              "${allData[0].location}",
                              "${allData[0].website}",
                              "${allData[0].address}"),
                          ProfileImageWidget(),
                          editPage(),
                        ],
                      ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _myAppBar3() {
    return Container(
      height: 80.0,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        gradient: new LinearGradient(
          colors: [
            const Color(0xFF1F3B7B),
            const Color(0xFF335599),
          ],
          begin: Alignment(-1.0, -2.0),
          end: Alignment(-2.0, -1.0),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 16.0),
        child: Center(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Container(
                child: IconButton(
                    icon: Icon(
                      FontAwesomeIcons.arrowLeft,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => HomePage()));
                    }),
              ),
            ),
            Expanded(
              flex: 5,
              child: Container(
                child: Text(
                  'PROFILE',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 30.0),
                ),
              ),
            ),
          ],
        )),
      ),
    );
  }
}

class CurvePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Rect rect = new Rect.fromLTRB(100, 150, 300, 400);

    final Gradient gradient = new LinearGradient(
      colors: [
        const Color(0xFF1F3B7B),
        const Color(0xFF335599),
      ],
      begin: Alignment(1.0, 2.0),
      end: Alignment(1.0, 3.0),
    );
    final Paint paint = new Paint()..shader = gradient.createShader(rect);

    var path = Path();

    path.moveTo(0, size.height * 0.27);
    path.quadraticBezierTo(
        size.width / 2, size.height / 2, size.width, size.height);
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class SizeConfig {
  static MediaQueryData _mediaQueryData;
  static double screenWidth;
  static double screenHeight;
  static double blockSizeHorizontal;
  static double blockSizeVertical;
  static double _safeAreaHorizontal;
  static double _safeAreaVertical;
  static double safeBlockHorizontal;
  static double safeBlockVertical;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    blockSizeHorizontal = screenWidth / 100;
    blockSizeVertical = screenHeight / 100;
    _safeAreaHorizontal =
        _mediaQueryData.padding.left + _mediaQueryData.padding.right;
    _safeAreaVertical =
        _mediaQueryData.padding.top + _mediaQueryData.padding.bottom;
    safeBlockHorizontal = (screenWidth - _safeAreaHorizontal) / 100;
    safeBlockVertical = (screenHeight - _safeAreaVertical) / 100;
  }
}

class ProfileImageWidget extends StatefulWidget {
  @override
  _ProfileImageWidgetState createState() => _ProfileImageWidgetState();
}

class _ProfileImageWidgetState extends State<ProfileImageWidget> {
  var height = 160.0;
  var width = 160.0;
  var shape = BoxShape.circle;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Positioned(
      top: SizeConfig.screenHeight / 13,
      left: SizeConfig.screenWidth / 3.65,
      child: Container(
          width: width,
          height: height,
          decoration: new BoxDecoration(
              shape: shape,
              image: new DecorationImage(
                  fit: BoxFit.fill,
                  image: new AssetImage("assets/person.png")))),
    );
  }
}
