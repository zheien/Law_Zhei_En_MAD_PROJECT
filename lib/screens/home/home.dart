import 'package:flutter/material.dart';
import 'package:project11/models/brew.dart';
import 'package:project11/screens/home/firstscreen/FirstScreen.dart';
import 'package:project11/screens/home/secondscreen/SecondScreen.dart';
import 'package:project11/screens/home/secondscreen/topup.dart';
import 'package:project11/screens/home/brew_list.dart';
import 'package:project11/screens/home/fourthscreen/settings_form.dart';
import 'package:project11/screens/home/thirdscreen/ThirdScreen.dart';
import 'package:project11/services/auth.dart';
import 'package:project11/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:project11/screens/home/fourthscreen/links.dart';

void main() {
  runApp(Home());
}

class Home extends StatefulWidget {
  final Function onTap;

  Home({this.onTap});
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String title = 'Home';
  int index = 0;
  final AuthService _auth = AuthService();
  //List<Widget> list = [Home(), Profile(), Setting()];
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 4,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.tealAccent[400],
            bottom: TabBar(
              tabs: [
                Tab(
                  icon: Icon(Icons.bus_alert, color: Colors.white, size: 30.0),
                ),
                Tab(
                    icon: Icon(Icons.card_membership_sharp,
                        color: Colors.white, size: 30.0)),
                Tab(
                    icon: Icon(Icons.list_alt_rounded,
                        color: Colors.white, size: 30.0)),
                Tab(
                    icon: Icon(Icons.miscellaneous_services,
                        color: Colors.white, size: 30.0)),
              ],
            ),
            title: Text(title),
            actions: <Widget>[
              FlatButton.icon(
                icon: Icon(Icons.person),
                label: Text('logout'),
                onPressed: () async {
                  await _auth.signOut();
                },
              ),
            ],
          ),
          body: TabBarView(
            children: [
              //FlipCard(),
              MyHomePage(),
              // (onTap: () {
              //   setState(() {
              //     title = 'Homexx';
              //     Navigator.pop(context);
              //   });
              // }),
              SecondScreen(),
              BusArrival(),
              Links(),
            ],
          ),
        ),
      ),
    );
  }
}
