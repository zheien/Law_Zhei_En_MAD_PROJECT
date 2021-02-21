import 'package:basic_utils/basic_utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:collection/collection.dart';
import 'package:project11/models/user.dart';
import 'package:provider/provider.dart';
import 'package:project11/services/database.dart';
import 'package:google_fonts/google_fonts.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _formKey = GlobalKey<FormState>();
  var _textController = new TextEditingController();
  clearTextInput() {
    _textController.clear();
  }

  TextEditingController editingController = TextEditingController();

  Future<List<Joke>> _getJokes() async {
    Map<String, String> headers = {
      "Accept": "application/json",
      "AccountKey": "IIqvBX+MQM2uHovC0RpM9w=="
    };
    String body = "{ 'some':'json'}";
    var data = await http.get(
        "http://datamall2.mytransport.sg/ltaodataservice/BusServices",
        headers: headers);
    var jsonData = json.decode(data.body);

    var data2 = await http.get(
        "http://datamall2.mytransport.sg/ltaodataservice/BusStops",
        headers: headers);
    var jsonData2 = json.decode(data2.body);

    List<Joke> jokes = [];
    String count = '0';
    for (var joke in jsonData["value"]) {
      for (var joke2 in jsonData2["value"]) {
        if (joke["DestinationCode"] == joke2["BusStopCode"]) {
          Joke newJoke = Joke(
              joke["ServiceNo"],
              joke["Operator"],
              joke["DestinationCode"],
              joke["Category"],
              joke["OriginCode"],
              joke2["BusStopCode"],
              joke2["Description"]);

          jokes.add(newJoke);
        }
      }
    }

    return jokes;
  }

  String _currentName;
  String _currentOccupations;
  int _currentAmount;
  @override
  Widget build(BuildContext context) {
    String service = 'default';
    String service2;
    return Wrap(
      children: <Widget>[
        Container(
          decoration: new BoxDecoration(
            // borderRadius: new BorderRadius.circular(16.0),
            // border: Border.all(
            //   color: Colors.purple[400],
            //   width: 2.0,
            // ),
            color: Colors.greenAccent,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                //color: Colors.deepPurple[200],
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextField(
                    // onChanged: (value) {
                    //   filterSearchResults(value);
                    // },
                    controller: editingController,
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        focusColor: Colors.white,
                        labelText: "Search",
                        hintText: "Search",
                        prefixIcon: Icon(Icons.search),
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(25.0)))),
                  ),
                ),
              ),
              FutureBuilder(
                future: _getJokes(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.data == null) {
                    return Container(
                      child: Center(
                        child: Text("Loading..."),
                      ),
                    );
                  } else {
                    return Container(
                      height: 480,
                      width: 410,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.greenAccent,
                              Colors.tealAccent[400]
                            ]),
                      ),

                      // color: Colors.purple[50],
                      // decoration: new BoxDecoration(
                      //   borderRadius: new BorderRadius.circular(16.0),
                      //   color: Colors.red,
                      // ),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(30, 5, 0, 0),
                        child: Container(
                          child: ListView.builder(
                            itemCount: snapshot.data.length,
                            itemBuilder: (BuildContext context, int index) {
                              for (int i = 0; i < snapshot.data.length; i++) {
                                service = snapshot.data[index].ServiceNo;
                                print(index);
                                print(snapshot.data.length);

                                // index = index + 1;
                                String image = "";
                                print(snapshot.data[index].Operator.toString());
                                if (snapshot.data[index].Operator.toString() ==
                                    "SBST") {
                                  image = 'images/sbs-icon.png';
                                } else if (snapshot.data[index].Operator
                                        .toString() ==
                                    "SMRT") {
                                  image = 'images/smrt-icon.png';
                                } else if (snapshot.data[index].Operator
                                        .toString() ==
                                    "TTS") {
                                  image = 'images/tts-icon.png';
                                } else if (snapshot.data[index].Operator
                                        .toString() ==
                                    "GAS") {
                                  image = 'images/gas-icon.png';
                                }
                                return Container(
                                  height: 150,
                                  width: 400,
                                  child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Wrap(
                                      children: <Widget>[
                                        Stack(
                                          // alignment: Alignment.bottomLeft,
                                          children: <Widget>[
                                            Container(
                                              height: 150,
                                              width: 390,
                                            ),
                                            new Positioned(
                                              left: 40,
                                              child: Container(
                                                height: 130,
                                                width: 310,
                                                decoration: new BoxDecoration(
                                                  borderRadius:
                                                      new BorderRadius.circular(
                                                          16.0),
                                                  border: Border.all(
                                                    color: Colors.white,
                                                    width: 2.0,
                                                  ),
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                            new Positioned(
                                              left: 15,
                                              top: 10,
                                              child: Container(
                                                height: 100,
                                                width: 350,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          110, 0, 0, 0),
                                                  child: ListTile(
                                                    // leading: Icon(Icons.bus_alert,
                                                    //     color: Colors.blue.shade400),
                                                    title: Padding(
                                                      padding: const EdgeInsets
                                                              .fromLTRB(
                                                          20, 0, 0, 0),
                                                      child: Text(
                                                        "Bus Num : " +
                                                                snapshot
                                                                    .data[index]
                                                                    .ServiceNo ??
                                                            'default value',
                                                        style:
                                                            GoogleFonts.roboto(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w900,
                                                                fontSize: 20,
                                                                color: Colors
                                                                    .black),
                                                      ),
                                                    ),

                                                    subtitle: Wrap(
                                                      alignment: WrapAlignment
                                                          .spaceBetween,
                                                      direction: Axis.vertical,
                                                      children: <Widget>[
                                                        SizedBox(height: 15),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .fromLTRB(
                                                                  20, 0, 0, 0),
                                                          child: Container(
                                                            child: Text(
                                                                '--------'),
                                                            color: Colors.amber,
                                                            height: 5,
                                                          ),
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: <Widget>[
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .fromLTRB(
                                                                      20,
                                                                      0,
                                                                      0,
                                                                      0),
                                                              child:
                                                                  RaisedButton(
                                                                shape:
                                                                    new RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      new BorderRadius
                                                                          .circular(30),
                                                                ),
                                                                // Icon(Icons.payments),
                                                                child:
                                                                    // Row(
                                                                    //   children: <Widget>[
                                                                    Text(
                                                                  "PAY FOR RIDE",
                                                                  style: TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                                ),
                                                                textColor:
                                                                    Colors
                                                                        .white,

                                                                // SizedBox(
                                                                //     width: 5),
                                                                // Icon(Icons
                                                                //     .payments)
                                                                //   ],
                                                                // ),
                                                                color: Colors
                                                                        .orangeAccent[
                                                                    400],
                                                                onPressed:
                                                                    () async {
                                                                  var route =
                                                                      new MaterialPageRoute(
                                                                    builder: (BuildContext
                                                                            context) =>
                                                                        new SecondPage(
                                                                            value:
                                                                                snapshot.data[index].ServiceNo),
                                                                  );

                                                                  Navigator.of(
                                                                          context)
                                                                      .push(
                                                                          route);
                                                                },
                                                              ),
                                                            ),
                                                            RaisedButton(
                                                                shape:
                                                                    new CircleBorder(),
                                                                child: Row(
                                                                  children: <
                                                                      Widget>[
                                                                    Icon(
                                                                      Icons
                                                                          .info,
                                                                      color: Colors
                                                                              .lightBlueAccent[
                                                                          400],
                                                                    )
                                                                  ],
                                                                ),
                                                                onPressed: () {
                                                                  showDialog(
                                                                      context:
                                                                          context,
                                                                      builder:
                                                                          (BuildContext
                                                                              context) {
                                                                        return AlertDialog(
                                                                          shape:
                                                                              RoundedRectangleBorder(
                                                                            borderRadius:
                                                                                new BorderRadius.circular(30),
                                                                          ),
                                                                          content:
                                                                              Stack(
                                                                            overflow:
                                                                                Overflow.visible,
                                                                            children: <Widget>[
                                                                              Container(
                                                                                height: 100,
                                                                                width: 400,
                                                                                child: Column(
                                                                                  children: <Widget>[
                                                                                    Text(
                                                                                      "Destination:" + snapshot.data[index].DestinationCode,
                                                                                      style: GoogleFonts.alef(fontSize: 20, color: Colors.black),
                                                                                    ),
                                                                                    Text(
                                                                                      snapshot.data[index].Description,
                                                                                      style: GoogleFonts.alef(fontSize: 20, color: Colors.black),
                                                                                    ),
                                                                                    InkResponse(
                                                                                      onTap: () {
                                                                                        Navigator.of(context).pop();
                                                                                      },
                                                                                      child: CircleAvatar(
                                                                                        child: Icon(Icons.close),
                                                                                        backgroundColor: Colors.red,
                                                                                      ),
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        );
                                                                      });
                                                                }),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            new Positioned(
                                              left: 1,
                                              top: 13,
                                              child: Image(
                                                image: AssetImage("$image"),
                                                height: 100,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }
                            },
                          ),
                        ),
                      ),
                      //),
                      // ),
                      //],
                      //),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  //var items = List<String>();

//   void filterSearchResults(String query) {
//     List duplicateItems = List<Joke>().toList();
//     List<String> SearchList = List<String>();

//     if (query.isNotEmpty) {
//       List<String> dummyListData = List<String>();
//       SearchList.forEach((item) {
//         if (item.contains(query)) {
//           dummyListData.add(item);
//         }
//       });
//       setState(() {
//         items.clear();
//         items.addAll(dummyListData);
//       });
//       return;
//     } else {
//       setState(() {
//         items.clear();
//       });
//     }
//   }
}

class SecondPage extends StatefulWidget {
  final String value;

  SecondPage({Key key, this.value}) : super(key: key);
  @override
  _SecondPageState createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  String _currentName;
  String _currentOccupations;
  int _currentAmount;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context);
    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          insertDataMethod() async {
            UserData userData = snapshot.data;
            String name = userData.name;

            String value = widget.value;
            String url =
                'http://192.168.1.12/testlocalhost/insertData.php?bus=$value&name=$name';
            var res = await http.post(Uri.encodeFull(url),
                headers: {"Accept": "application/json"});
            body:
            {
              //"name":name;
            }

            var responseBody = json.decode(res.body);
          }

          if (snapshot.hasData) {
            return Form(
              key: _formKey,
              child: Scaffold(
                appBar: new AppBar(
                  title: new Text("Second Page"),
                ),
                body: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.check_circle_rounded,
                        color: Colors.green.shade400,
                        size: 60.0,
                      ),
                      Text(
                        'Your payment has been confirmed for bus ' +
                            widget.value,
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                      RaisedButton(
                        onPressed: () async {
                          insertDataMethod();
                          if (_formKey.currentState.validate()) {
                            await DatabaseService(uid: user.uid).updateUserData(
                                _currentOccupations ??
                                    snapshot.data.occupations,
                                _currentName ?? snapshot.data.name,
                                _currentAmount ?? snapshot.data.amount - 1);
                            Navigator.pop(context);
                          }
                        },
                        child: Text('Back'),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
          // insertDataMethod() async {
          //   UserData userData = snapshot.data;
          //   String name = userData.name;
          //   String url =
          //       'http://192.168.68.105/testlocalhost/insertData.php?name=$name';
          //   var res = await http.post(Uri.encodeFull(url),
          //       headers: {"Accept": "application/json"});
          //   // body:{
          //   //   "name":name;
          //   // }

          //   var responseBody = json.decode(res.body);
          // }
        });
  }
}

class Joke {
  final String ServiceNo;
  final String Operator;
  final String DestinationCode;
  final String Category;
  final String OriginCode;
  final String BusStopCode;
  final String Description;

  Joke(this.ServiceNo, this.Operator, this.DestinationCode, this.Category,
      this.OriginCode, this.BusStopCode, this.Description);
}
