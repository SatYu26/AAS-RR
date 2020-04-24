import 'package:flutter/material.dart';
import 'auth.dart';
import 'ForgotScreen.dart';

class LoginPage extends StatefulWidget {
  LoginPage({this.auth, this.onSignedIn});
  final BaseAuth auth;
  final VoidCallback onSignedIn;

  @override
  State<StatefulWidget> createState() => new _LoginPageState();
}

enum FormType { login, register } // enumeration

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  final formKey = new GlobalKey<FormState>();
  AnimationController _iconAnimationController;
  Animation<double> _iconAnimation;
  String _email;
  String _password;
  FormType _formType = FormType.login;

  bool validateAndSave() {
    final form = formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  } //validateAndSave

  void validateAndSubmit() async {
    if (validateAndSave()) {
      try {
        if (_formType == FormType.login) {
          String userId =
              await widget.auth.signInWithEmailAndPassword(_email, _password);
//          FirebaseUser user = (await FirebaseAuth.instance
//                  .signInWithEmailAndPassword(
//                      email: _email, password: _password))
//              .user;
          print('Signed in: $userId');
        } else {
          String userId = await widget.auth
              .createUserWithEmailAndPassword(_email, _password);

//          FirebaseUser user = (await FirebaseAuth.instance
//                  .createUserWithEmailAndPassword(
//                      email: _email, password: _password))
//              .user;
          print('Registered user: $userId');
        }
        widget.onSignedIn();
      } catch (e) {
        print('Error: $e');
      }
    }
  } // validateAndSubmit

  void moveToRegister() {
    formKey.currentState.reset();
    setState(() {
      _formType = FormType.register;
    });
  } // moveToRegister

  void moveToLogin() {
    formKey.currentState.reset();
    setState(() {
      _formType = FormType.login;
    });
  } //moveToLogin

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
    return new Scaffold(
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
                key: formKey,
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
                      children: buildInputs() + buildSubmitButtons(),
                    ),
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
    if (_formType == FormType.login) {
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
        new TextFormField(
          decoration: new InputDecoration(
            labelText: "Enter Password",
          ),
          validator: (value) =>
              value.isEmpty ? 'Please enter valid Password' : null,
          onSaved: (value) => _password = value,
          keyboardType: TextInputType.text,
          obscureText: true,
        ),
      ];
    } else {
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
        new TextFormField(
          decoration: new InputDecoration(
            labelText: "Enter Password",
          ),
          validator: (value) =>
              value.isEmpty ? 'Please enter valid Password' : null,
          onSaved: (value) => _password = value,
          keyboardType: TextInputType.text,
          obscureText: true,
        ),
      ];
    }
  }

  List<Widget> buildSubmitButtons() {
    if (_formType == FormType.login) {
      return [
        new Padding(padding: const EdgeInsets.only(top: 40.0)),
        new MaterialButton(
          height: 40.0,
          minWidth: 100.0,
          color: Colors.teal,
          textColor: Colors.white,
          child: new Text("Login"),
          onPressed: validateAndSubmit,
          splashColor: Colors.lightGreenAccent,
        ),
        Center(
          child: new Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(8,5,8,0),
                child: new FlatButton(
                  child: new Text('Forgot Password ?',
                      style: new TextStyle(fontSize: 10.0)),
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => ForgotScreen()));
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20,5,8,0),
                child: new FlatButton(
                  child: new Text('Create an Account',
                      style: new TextStyle(fontSize: 10.0)),
                  onPressed: moveToRegister,
                ),
              ),
            ],
          ),
        )
      ];
    } else {
      return [
        new Padding(padding: const EdgeInsets.only(top: 30.0)),
        new MaterialButton(
          height: 40.0,
          minWidth: 100.0,
          color: Colors.teal,
          textColor: Colors.white,
          child: new Text("Create an Account"),
          onPressed: validateAndSubmit,
          splashColor: Colors.lightGreenAccent,
        ),
        new FlatButton(
          child: new Text('Have an Account? Login',
              style: new TextStyle(fontSize: 10.0)),
          onPressed: moveToLogin,
        ),
      ];
    }
  }
}
