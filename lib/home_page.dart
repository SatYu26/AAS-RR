import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:robic/auth.dart';
import 'swipelist_home.dart';
import 'package:robic/Profile_Page_UI.dart';
import 'package:robic/profile_page2.dart';

class HomePage extends StatefulWidget {
  HomePage({this.auth, this.onSignedOut});
  final BaseAuth auth;
  final VoidCallback onSignedOut;

  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // final key = new GlobalKey<ListItemWidget>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('AERATORS'),
        flexibleSpace: Container(
          decoration: new BoxDecoration(
            gradient: new LinearGradient(
                colors: [
                  const Color(0xFF1F3B7B),
                  const Color(0xFF335599),
                ],
                begin: Alignment(-1.0, -2.0),
                end: Alignment(-2.0, -1.0),
                tileMode: TileMode.clamp),
          ),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                colors: <Color>[Color(0xFF1F3B7B), Color(0xFF335599)],
                begin: Alignment(-1.0, -2.0),
                end: Alignment(-2.0, -1.0),
              )),
              child: Container(
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Image.asset(
                        'assets/4.png',
                        width: 80,
                        height: 80,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'ROBIC RUFARM',
                        style: TextStyle(color: Colors.white, fontSize: 20.0),
                      ),
                    )
                  ],
                ),
              ),
            ),
            CustomListTile(Icons.person, 'Profile', () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ShowDataPage()));
            }),
            CustomListTile(Icons.text_fields, 'Update My Info.', () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ProfilePage()));
            }),
            CustomListTile(Icons.lock_open, 'Log Out', ()=> widget.onSignedOut()),
          ],
        ),
      ),
      body: new SwipeList(),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      // floatingActionButton: Padding(
      //   padding: const EdgeInsets.all(16.0),
      //   child: Container(
      //     width: 70.0,
      //     height: 70.0,
      //     child: FloatingActionButton(
      //       hoverColor: Colors.lightGreenAccent,
      //       splashColor: Colors.teal,
      //       elevation: 15.0,
      //       onPressed: () {
      //         swipeList.state.addItem(context);
      //       },
      //       tooltip: 'New Aerator',
      //       child: Icon(
      //         Icons.add,
      //         color: Colors.white,
      //       ),
      //       backgroundColor: Colors.green,
      //     ),
      //   ),
      // ),
    );
  }
}

class CustomListTile extends StatelessWidget {
  final IconData icon;
  final String text;
  final Function onTap;
  CustomListTile(this.icon, this.text, this.onTap);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 0),
      child: Container(
        decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.grey.shade400))),
        child: InkWell(
          splashColor: Color(0xFF1F3B7B),
          onTap: onTap,
          child: Container(
            height: 60,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Icon(icon),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        text,
                        style: TextStyle(
                          fontSize: 20.0,
                        ),
                      ),
                    ),
                  ],
                ),
                Icon(Icons.arrow_right)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
