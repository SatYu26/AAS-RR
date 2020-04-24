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
  final _aeratorIdFormKey = GlobalKey<FormState>();
  // List _items;
  List<String> itemList;
  List get items => itemList;
  Map<String, bool> val = {};

  @override
  void initState() {
    super.initState();
    itemList = getDummyList();
  }
  Future<String> asyncGetAeratorIdDialog(BuildContext context) async {
    String id = '';
    return showDialog<String>(
      context: context,
      barrierDismissible: false, // dialog is dismissible with a tap on the barrier
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Enter new aerator ID'),
          content: new Form(
            key: _aeratorIdFormKey,
            child: Row(
              children: <Widget>[
                new Expanded(
                  child: new TextFormField(
                  autovalidate: true,
                  autofocus: true,
                  decoration: new InputDecoration(
                    labelText: 'Aerator ID'
                  ),
                  onSaved: (String value) {
                    id = value;
                  },
                  validator: (String value) {
                    if(value.isEmpty)
                      return "This can't be empty";
                    return (itemList.contains("$value"))?"This ID already exists":null;
                  }
                ),
                )
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Ok', style: TextStyle(color: Color(0xFF1D262D)),),
              onPressed: () {
                if(_aeratorIdFormKey.currentState.validate()){
                  print("We entered here....");
                  _aeratorIdFormKey.currentState.save();
                  print("id: $id");
                  Navigator.of(context).pop(id);
                }
              },
            ),
          ],
        );
      },
    );
  }


  void addItem() {
    asyncGetAeratorIdDialog(context).then((result) {
      if(result==null) {
        return;
      } else {
        setState(() {
          itemList.add("$result");
          val[itemList[itemList.length - 1]] = false;
        });
      }
    });
  }

  onSwitchValueChanged(bool newVal, index) {
    setState(() {
      val[itemList[index]] = newVal;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          width: 70.0,
          height: 70.0,
          child: FloatingActionButton(
            hoverColor: Colors.white,
            splashColor: Color(0xFF335599),
            elevation: 15.0,
            onPressed: () {
              addItem();
            },
            tooltip: 'New Aerator',
            child: Icon(
              Icons.add,
              color: Colors.white,
            ),
            backgroundColor: Color(0xFF335599),
          ),
        ),
      ),
      body: new Container(
    height: MediaQuery.of(context).size.height,
    width: MediaQuery.of(context).size.width,
    decoration: BoxDecoration(
    gradient: LinearGradient(
    colors: [Color(0xFF1F3B7B), Color(0xFF335599)],
      begin: Alignment(1.0, 2.0),
      end: Alignment(1.0, 3.0),
    ),),
        child: Container(
        child: ListView.builder(
        itemCount: itemList.length,
        itemBuilder: (context, index) {
          return Dismissible(
            key: Key(itemList[index]),
            background: Container(
              alignment: AlignmentDirectional.centerEnd,
              color: Colors.red,
              child: Icon(
                Icons.delete,
                color: Colors.white,
              ),
            ),
            onDismissed: (direction) {
              setState(() {
                val[itemList[index]] = false;
                itemList.remove(itemList[index]);
              });
            },
            direction: DismissDirection.endToStart,
            child: Center(
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                color: Colors.white,
                margin:  EdgeInsets.fromLTRB(6,25,6,7),
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
                                  image: AssetImage("assets/aerator.png"))),
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
                                    border: Border.all(color: Color(0xFF335599)),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(50))),
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
      )
    )
    ));
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
    List<String> list = List.generate((3), (i) {
      val["Aerator ${i+1}"] = false;
      return "Aerator ${i + 1}";
    }, growable: true);
    return list;
  }
}
