import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:project11/models/user.dart';
import 'package:project11/services/database.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter',
      home: Entry(),
    );
  }
}

class Entry extends StatefulWidget {
  @override
  _EntryState createState() => _EntryState();
}

class _EntryState extends State<Entry> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context);
    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          getMethod() async {
            UserData userData = snapshot.data;
            String name = userData.name;
            print(name);
            String url =
                'http://192.168.1.12/testlocalhost/getData.php?name=$name';
            var res = await http.get(Uri.encodeFull(url),
                headers: {"Accept": "application/json"});
            var responseBody = json.decode(res.body);
            print(responseBody);
            return responseBody;
          }

          return Scaffold(
            body: FutureBuilder(
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.data == null) {
                  return Container(
                    child: Center(
                      child: Text("Loading..."),
                    ),
                  );
                } else {
                  List snap = snapshot.data;

                  return ListView.builder(
                    itemCount: snap.length,
                    itemBuilder: (context, index) {
                      DateTime tempDate = new DateFormat("yyyy-MM-dd hh:mm:ss")
                          .parse("${snap[index]['dateTime']}");
                      String date = DateFormat("yyyy-MM-dd hh:mm:ss")
                          .format(tempDate)
                          .toString();
                      // // print(date);
                      // DateTime dateTime2 =
                      //     DateTime.parse("${snap[index]['dateTime']}");
                      print("${snap[index]}");
                      String bus = "${snap[index]['bus']}".toString();

                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child:
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.center,
                            //   children: [
                            // Container(color: Colors.amber, width: 10),
                            Container(
                          //   // width: 10,
                          decoration: new BoxDecoration(
                            borderRadius: new BorderRadius.circular(16.0),
                            color: Colors.purple[50],
                          ),
                          child:
                              //Row(
                              //   children: [
                              // SizedBox(width: 10),
                              ListTile(
                            title: Text("Bus : $bus"),
                            subtitle: Text("Booked on : $date"),
                          ),
                          //   ],
                          // ),
                          //   ),
                          // ],
                        ),
                        // ),
                      );
                    },
                  );
                }
              },
              future: getMethod(),
            ),
          );
        });
  }
}
