import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:robic/home_page.dart';
import 'login_page.dart';
import 'auth.dart';
import 'home_page.dart';
// import 'profile_page.dart';

class RootPage extends StatefulWidget {
  RootPage({this.auth});
  final BaseAuth auth;
  @override
  State<StatefulWidget> createState() => new _RootPageState();
}

enum AuthStatus { notSignedIn, SignedIn }

class _RootPageState extends State<RootPage> {
  AuthStatus authStatus = AuthStatus.notSignedIn;

  @override
  void initState() {
    super.initState();
    widget.auth.currentUser().then((userId) {
      setState(() {
        authStatus =
            userId == null ? AuthStatus.notSignedIn : AuthStatus.SignedIn;
      });
    });
  }

  void _signedIn() {
    setState(() {
      authStatus = AuthStatus.SignedIn;
    });
  }

  void _signedOut() {
    setState(() {
      authStatus = AuthStatus.notSignedIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    switch (authStatus) {
      case AuthStatus.notSignedIn:
        return new LoginPage(
          auth: widget.auth,
          onSignedIn: _signedIn,
        );
      case AuthStatus.SignedIn:
        return new HomePage(
          auth: widget.auth,
          onSignedOut: _signedOut,
        );
    }
    return Container(
      child: Center(
        child: Text("Auth status unknown, please restart the application or contact the developer"),
      )
    );
  }
}
