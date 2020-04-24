import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'login_page.dart';
import 'auth.dart';
import 'root_page.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new RootPage(auth: new Auth()),
      theme: new ThemeData(primarySwatch: Colors.green),
    );
  }
}
