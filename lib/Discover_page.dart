import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class DiscoverPage extends StatefulWidget {
  @override
  _DiscoverPageState createState() => new _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage> {
  final df = new DateFormat('dd-MM-yyyy');
  User selectedUser;
  List<User> users = <User>[
    const User('Gujarat'),
    const User('tamil nadu'),
    const User('assam'),
    const User('bihar'),
    const User('UP'),
    const User('AP'),
    const User('rajasthan'),
    const User('telengana'),
    const User('kerala'),
    const User('WB'),
    const User('haryana'),
    const User('JK'),
    const User('MP'),
    const User('Maharashtra'),
  ];

  _openURL() async {
    const url = 'https://robicrufarm.com/';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: new AppBar(
          title: Text('DISCOVER'),
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
            child: bodyMain(),
          ),
        ));
  }

  Widget bodyMain() => Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(2, 16, 2, 8),
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(5, 8, 2, 8),
                  child: Container(
                    height: 50.0,
                    width: 50.0,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(10),
                            topLeft: Radius.circular(10)),
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage("assets/aerator.png"))),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(2, 8, 8, 8),
                  child: Column(
                    children: <Widget>[
                      new Text(
                        'VANNAMEI',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 25,
                            fontWeight: FontWeight.bold),
                      ),
                      new Text(
                        df.format(new DateTime.now()),
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: new DropdownButton<User>(
                    hint: new Text("State"),
                    value: selectedUser,
                    onChanged: (User newValue) {
                      setState(() {
                        selectedUser = newValue;
                      });
                    },
                    items: users.map((User user) {
                      return new DropdownMenuItem<User>(
                        value: user,
                        child: new Text(
                          user.name,
                          style: new TextStyle(color: Colors.black),
                        ),
                      );
                    }).toList(),
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: new Container(
                  child: Theme(
                data: Theme.of(context).copyWith(dividerColor: Colors.green),
                child: bodyData(),
              )),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(2, 32, 115, 8),
            child: Text(
              'Learn Aquaculture',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 25,
                  decoration: TextDecoration.underline,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.left,
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(28, 8, 8, 8),
            child: Text(
              'Keep yourself educated, informative and updated about aquaculture.Visit Our Website:',
              style: TextStyle(
                color: Colors.black,
                fontSize: 15,
              ),
              softWrap: true,
              textAlign: TextAlign.left,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              child: Text(
                'www.robicrufarm.com',
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 15,
                ),
                softWrap: true,
                textAlign: TextAlign.left,
              ),
              onTap: () {
                _openURL();
              },
            ),
          )
        ],
      );

  Widget bodyData() => DataTable(
      onSelectAll: (b) {},
      sortColumnIndex: 1,
      sortAscending: true,
      columns: <DataColumn>[
        DataColumn(
          label: Text(
            "Count",
            style: TextStyle(
              color: Colors.black87,
              fontSize: 25,
            ),
          ),
          numeric: false,
          onSort: (i, b) {
            print("$i $b");
            setState(() {
              names.sort((a, b) => a.Count.compareTo(b.Count));
            });
          },
        ),
        DataColumn(
          label: Text(
            "Prices(.in Rs)",
            style: TextStyle(color: Colors.black87, fontSize: 25),
          ),
          numeric: false,
          onSort: (i, b) {
            print("$i $b");
            setState(() {
              names.sort((a, b) => a.Prices.compareTo(b.Prices));
            });
          },
        ),
      ],
      rows: names
          .map(
            (name) => DataRow(
              cells: [
                DataCell(
                  Center(
                    child: Text(
                      name.Count,
                      style: TextStyle(fontSize: 17),
                    ),
                  ),
                  showEditIcon: false,
                  placeholder: false,
                ),
                DataCell(
                  Center(
                    child: Text(
                      name.Prices,
                      style: TextStyle(fontSize: 17),
                    ),
                  ),
                  showEditIcon: false,
                  placeholder: false,
                )
              ],
            ),
          )
          .toList());
}

class User {
  const User(this.name);

  final String name;
}

class Name {
  String Count;
  String Prices;

  Name({this.Count, this.Prices});
}

var names = <Name>[
  Name(Count: "20C", Prices: "670"),
  Name(Count: "25C", Prices: "520"),
  Name(Count: "26C", Prices: "500"),
  Name(Count: "27C", Prices: "600"),
  Name(Count: "28C", Prices: "650"),
  Name(Count: "29C", Prices: "610"),
];
