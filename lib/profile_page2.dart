import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:robic/Profile_Page_UI.dart';
import 'auth.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({this.auth});
  final BaseAuth auth;

  @override
  _ProfilePageState createState() => new _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  GlobalKey<FormState> _key = new GlobalKey();
  bool _autovalidate = false;
  String name, number, address, location, website;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.grey,
      appBar: new AppBar(
        title: Text('PROFILE'),
        flexibleSpace: Container(
          decoration: new BoxDecoration(
            gradient: new LinearGradient(
                colors: [
                  const Color(0xFF1F3B7B),
                  const Color(0xFF335599),
                ],
                begin: const Alignment(-1.0, -1.0),
                end: const Alignment(1.0, 1.0),
                tileMode: TileMode.clamp),
          ),
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFECF3FB), Colors.white],
            begin: Alignment(-1.0, -3.0),
            end: Alignment(1.0, 3.0),
          ),
        ),
        child: new SingleChildScrollView(
          child: new Container(
            padding: new EdgeInsets.all(15.0),
            child: new Form(
              key: _key,
              autovalidate: _autovalidate,
              child: FormUI(),
            ),
          ),
        ),
      ),
    );
  }

  Widget FormUI() {
    return new Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        new Row(
          children: <Widget>[
            new Flexible(
              child: new TextFormField(
                decoration: new InputDecoration(hintText: 'Name'),
                keyboardType: TextInputType.text,
                validator: validateName,
                onSaved: (val) {
                  name = val;
                },
                maxLines: 1,
                maxLength: 32,
              ),
            ),
          ],
        ),
        new TextFormField(
            decoration: new InputDecoration(hintText: 'Mobile Number'),
            keyboardType: TextInputType.phone,
            validator: validateMobile,
            onSaved: (val) {
              number = val;
            },
            maxLines: 1,
            maxLength: 10),
        new TextFormField(
          decoration: new InputDecoration(hintText: 'Location'),
          onSaved: (val) {
            location = val;
          },
          maxLines: 1,
        ),
        new TextFormField(
          decoration: new InputDecoration(hintText: 'Website'),
          onSaved: (val) {
            website = val;
          },
        ),
        new TextFormField(
          decoration: new InputDecoration(hintText: 'Address'),
          onSaved: (val) {
            address = val;
          },
          validator: validateMessage,
          maxLines: 4,
          maxLength: 256,
        ),
        new MaterialButton(
          height: 40.0,
          minWidth: 100.0,
          color: Color(0xFF1D262D),
          textColor: Colors.white,
          child: new Text('Save'),
          onPressed: () {
            _sendToServer();
          },
          splashColor: Color(0xFF335599),
        ),
        new SizedBox(height: 20.0),
        new MaterialButton(
          height: 40.0,
          minWidth: 100.0,
          color: Color(0xFF1D262D),
          textColor: Colors.white,
          child: new Text('My Profile'),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => new ShowDataPage()));
          },
          splashColor: Color(0xFF335599),
        ),
      ],
    );
  }

  _sendToServer() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    if (_key.currentState.validate()) {
      _key.currentState.save();
      DatabaseReference ref = FirebaseDatabase.instance.reference();
      var data = {
        "id": user.uid,
        "name": name,
        "number": number,
        "address": address,
        "location": location,
        "website": website,
      };
      ref.child('node-name').child(user.uid).set(data).then((v) {
        _key.currentState.reset();
      });
    } else {
      setState(() {
        _autovalidate = true;
      });
    }
  }

  String validateName(String val) {
    return val.length == 0 ? "Enter Name First" : null;
  }

  String validateMessage(String val) {
    return val.length == 0 ? "Enter Address First" : null;
  }

  String validateMobile(String value) {
    if (value.length != 10)
      return 'Mobile Number must be of 10 digit';
    else
      return null;
  }
}
