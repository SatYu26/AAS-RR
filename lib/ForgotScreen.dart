import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'auth.dart';
import 'login_page.dart';

class ForgotScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ForgotScreen();
  }
}

class _ForgotScreen extends State<ForgotScreen>
    with SingleTickerProviderStateMixin {
  String _email;
  final formKeyf = new GlobalKey<FormState>();

  AnimationController _iconAnimationController;
  Animation<double> _iconAnimation;

  @override
  void initState() {
    super.initState();
    _iconAnimationController = new AnimationController(
      vsync: this,
      duration: new Duration(milliseconds: 500),
    );
    _iconAnimation = new CurvedAnimation(
      parent: _iconAnimationController,
      curve: Curves.easeOut,
    );
    _iconAnimation.addListener(() => this.setState(() {}));
    _iconAnimationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.black,
      body: new Stack(
        fit: StackFit.expand,
        children: <Widget>[
          new Image(
            image: new AssetImage("assets/3.jpg"),
            fit: BoxFit.cover,
            color: Colors.black87,
            colorBlendMode: BlendMode.darken,
          ),
          new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Image(
                image: new AssetImage("assets/4.png"),
                width: _iconAnimation.value * 100,
                height: _iconAnimation.value * 100,
              ),
              new Form(
                key: formKeyf,
                child: new Theme(
                  data: new ThemeData(
                      brightness: Brightness.dark,
                      primarySwatch: Colors.teal,
                      inputDecorationTheme: new InputDecorationTheme(
                          labelStyle: new TextStyle(
                              color: Colors.teal, fontSize: 20.0))),
                  child: new Container(
                    padding: const EdgeInsets.all(40.0),
                    child: new Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: buildInputs() + buildSubmitButtons()),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  List<Widget> buildInputs() {
    return [
      new TextFormField(
        decoration: new InputDecoration(
          labelText: "Enter Email",
        ),
        validator: (value) =>
            value.isEmpty ? 'Please enter valid Email address' : null,
        onSaved: (value) => _email = value,
        keyboardType: TextInputType.emailAddress,
      ),
    ];
  }

  List<Widget> buildSubmitButtons() {
    return [
      new Padding(padding: const EdgeInsets.only(top: 40.0)),
      new MaterialButton(
        height: 40.0,
        minWidth: 100.0,
        color: Colors.teal,
        textColor: Colors.white,
        child: new Text("Submit"),
        onPressed: () {
          validateAndSubmit();
          formKeyf.currentState.reset();
          asyncGetAeratorIdDialog(context);
        },
        splashColor: Colors.lightGreenAccent,
      ),
    ];
  }

  bool validateAndSave() {
    final form = formKeyf.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  } //validateAndSave

  void validateAndSubmit() async {
    if (validateAndSave()) {
      try {
        FirebaseAuth.instance.sendPasswordResetEmail(email: _email).then(
            (value) =>
                print("Please Check Your E-mail for Further Instructions"));
      } catch (e) {
        print('Error: $e');
      }
    }
  }

  Future<String> asyncGetAeratorIdDialog(BuildContext context) async {
    return showDialog<String>(
      context: context,
      barrierDismissible:
          false, // dialog is dismissible with a tap on the barrier
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            "Please Check Your E-mail for Further Instructions after submitting the email address",
            style: TextStyle(
                color: Colors.black, fontSize: 15, fontFamily: 'Montserrat'),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text(
                'Exit',
                style: TextStyle(color: Color(0xFF1D262D)),
              ),
              onPressed: () {
                SystemNavigator.pop();
              },
            ),
          ],
        );
      },
    );
  }
}
