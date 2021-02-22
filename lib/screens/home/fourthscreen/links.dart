import 'package:flutter/material.dart';
import 'package:project11/screens/home/fourthscreen/busBooking.dart';
import 'package:project11/screens/home/fourthscreen/chart/ThirdScreen.dart';
import 'package:project11/screens/home/fourthscreen/contactus.dart';
import 'package:project11/screens/home/secondscreen/topup.dart';
import 'AboutPage.dart';
import 'settings_form.dart';

class Links extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    void _showSettingsPanel() {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
              child: SettingsForm(),
            );
          });
    }

    return Container(
      height: 480,
      width: 410,
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.greenAccent, Colors.tealAccent[400]]),
      ),
      child: Column(
        children: [
          SizedBox(height: 10),
          Container(
            decoration: new BoxDecoration(
              color: Colors.white,
              borderRadius: new BorderRadius.circular(16.0),
            ),
            height: 530,
            width: 380,
            child: ListView(
              children: <Widget>[
                ListTile(
                  leading: Icon(Icons.phone_callback),
                  title: Text('Contact Us'),
                  onTap: () {
                    var route = new MaterialPageRoute(
                      builder: (BuildContext context) => new Contact(),
                    );
                    Navigator.of(context).push(route);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.person),
                  title: Text('About Us'),
                  onTap: () {
                    var route = new MaterialPageRoute(
                      builder: (BuildContext context) => new About(),
                    );
                    Navigator.of(context).push(route);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.settings),
                  title: Text('Update Profile'),
                  onTap: () => _showSettingsPanel(),
                ),
                ListTile(
                  leading: Icon(Icons.bar_chart),
                  title: Text('Transaction Lists ( Charts )'),
                  onTap: () {
                    var route = new MaterialPageRoute(
                      builder: (BuildContext context) => new MyApp2(),
                    );
                    Navigator.of(context).push(route);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.list_alt),
                  title: Text('Bus Booking Transactions'),
                  onTap: () {
                    var route = new MaterialPageRoute(
                      builder: (BuildContext context) => new MyApp(),
                    );
                    Navigator.of(context).push(route);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
