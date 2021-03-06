import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class SwipeList extends StatefulWidget {
  SwipeList({Key key}) : super(key: key);
  //var index = 0;
  @override
  State<StatefulWidget> createState() => new ListItemWidget();
}

class ListItemWidget extends State<SwipeList> {
  // List _items;
  List<String> itemList;
  List get items => itemList;
  Map<String, bool> val = {};

  @override
  void initState() {
    super.initState();
    itemList = getDummyList();
  }

  onSwitchValueChanged(bool newVal, index) {
    setState(() {
      val[itemList[index]] = newVal;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: new Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF1F3B7B), Color(0xFF335599)],
                begin: Alignment(1.0, 2.0),
                end: Alignment(1.0, 3.0),
              ),
            ),
            child: Container(
                child: ListView.builder(
              itemCount: itemList.length,
              itemBuilder: (context, index) {
                return Container(
                  key: Key(itemList[index]),
                  child: Center(
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      color: Colors.white,
                      margin: EdgeInsets.fromLTRB(6, 25, 6, 7),
                      elevation: 5,
                      child: Container(
                        height: 170.0,
                        width: 340,
                        child: Row(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Container(
                                height: 80.0,
                                width: 80.0,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(10),
                                        topLeft: Radius.circular(10)),
                                    image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image:
                                            AssetImage("assets/aerator.png"))),
                              ),
                            ),
                            Container(
                              height: 140,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(0, 3, 0, 2),
                                    child: Text(
                                      items[index],
                                      style: TextStyle(
                                          fontSize: 27,
                                          color: Color(0xFF1D262D),
                                          fontFamily: 'Montserrat'),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(16, 25, 0, 3),
                                    child: Container(
                                      width: 80,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Color(0xFF335599)),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(50))),
                                      child: new Column(
                                        children: toggleButton(index),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ))));
  }

  // List<Widget> codeField() {
  //   return [
  //     new TextFormField(
  //       decoration: new InputDecoration(
  //         labelText: "Code",
  //       ),
  //       validator: (value) => value.isEmpty ? 'Please Enter Code' : null,
  //       keyboardType: TextInputType.text,
  //     ),
  //   ];
  // }

  List<Widget> toggleButton(int index) {
    return [
      SizedBox(
        width: 70,
        height: 30,
        child: Switch(
          value: val[itemList[index]],
          onChanged: (newVal) {
            onSwitchValueChanged(newVal, index);
          },
          inactiveThumbColor: Colors.white,
          inactiveTrackColor: Color(0xFF1D262D),
          activeTrackColor: Color(0xFF335599),
          activeColor: Colors.white,
        ),
      ),
    ];
  }

  List getDummyList() {
    List<String> list = List.generate((5), (i) {
      val["RRAED00${i + 1}"] = false;
      return "RRAED00${i + 1}";
    }, growable: true);
    return list;
  }
}
