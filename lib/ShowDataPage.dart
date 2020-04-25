import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'myData.dart';

class ShowDataPage extends StatefulWidget {
  @override
  _ShowDataPageState createState() => _ShowDataPageState();
}

class _ShowDataPageState extends State<ShowDataPage> {
  List<myData> allData = [];

  // this is the code which i was using to fetch data from realtime database. i have not modified my code as i dont know how to do this part.
  @override
  void initState() {
    DatabaseReference ref = FirebaseDatabase.instance.reference();
    ref.child('node-name').once().then((DataSnapshot snap) {
      var keys = snap.value.keys;
      var data = snap.value;
      allData.clear();
      for (var key in keys) {
        myData d = new myData(
          data[key]['name'],
          data[key]['message'],
          data[key]['profession'],
        );
        allData.add(d);
      }
      setState(() {
        print('Length : ${allData.length}');
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('All User Data'),
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
      body: new Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF1F3B7B), Color(0xFF335599)],
              begin: Alignment(-1.0, -3.0),
              end: Alignment(1.0, 3.0),
            ),),
          child: allData.length == 0
              ? new Text(' No Data is Available', style: TextStyle(color: Colors.white),)
              : new ListView.builder(
            itemCount: allData.length,
            itemBuilder: (_, index) {
              return UI(
                allData[index].name,
                allData[index].profession,
                allData[index].message,
              );
            },
          )),
    );
  }

  Widget UI(String name, String profession, String message) {
    return new Card(
      elevation: 10.0,
      child: new Container(
        padding: new EdgeInsets.all(20.0),
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new Text('Name : $name',style: Theme.of(context).textTheme.title,),
            new Text('Profession : $profession'),
            new Text('Message : $message'),
          ],
        ),
      ),
    );
  }
}