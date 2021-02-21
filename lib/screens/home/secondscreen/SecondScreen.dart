import 'dart:math';
import 'package:charts_flutter/flutter.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project11/models/user.dart';
import 'package:project11/screens/home/secondscreen/topup.dart';
import 'package:project11/services/database.dart';
import 'package:project11/shared/constants.dart';
import 'package:project11/shared/loading.dart';
import 'package:provider/provider.dart';
import 'package:rounded_modal/rounded_modal.dart';

class SecondScreen extends StatefulWidget {
  @override
  _SecondScreenState createState() => _SecondScreenState();
}

class _SecondScreenState extends State with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation _animation;
  AnimationStatus _animationStatus = AnimationStatus.dismissed;
  final _formKey = GlobalKey<FormState>();

  //final List<int> amounts = [0, 10, 20, 30, 40, 50, 60, 70, 80, 90];
  String _currentName;
  String _currentOccupations;
  int _currentAmount;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    _animation = Tween(end: 1, begin: 0.0).animate(_animationController)
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        _animationStatus = status;
      });
  }

  @override
  Widget build(BuildContext context) {
    void _showTopUpScreen() {
      showModalBottomSheet(
          elevation: 10.0,
          isScrollControlled: true,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
          ),
          context: context,
          builder: (context) {
            return Padding(
              padding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
              child: Container(
                child: Container(
                  child: TopUpScreen(),
                ),
                // width: 500.0,
                // height: 400.0,
                decoration: BoxDecoration(
                  //color: Colors.red,
                  // shape: BoxShape.circle,
                  image: DecorationImage(
                    image: AssetImage('images/card.jpg'),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              //TopUpScreen(),
              //   ],
              // ),
            );
          });
    }

    // void _showUpdateScreen() {
    //   showModalBottomSheet(
    //       context: context,
    //       builder: (context) {
    //         return Container(
    //           padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
    //           child: UpdateScreen(),
    //         );
    //       });
    // }

    User user = Provider.of<User>(context);
    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserData userData = snapshot.data;
            String name = userData.name;
            int amount = userData.amount;
            return Form(
              key: _formKey,
              child: Container(
                height: 480,
                width: 410,
                decoration: BoxDecoration(
                  // color: Colors.purple[50],
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.greenAccent, Colors.tealAccent[400]]),
                ),
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 10),
                    Container(
                      decoration: new BoxDecoration(
                        color: Colors.white,
                        borderRadius: new BorderRadius.circular(16.0),
                      ),
                      height: 100,
                      width: 380,
                      child: Row(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Container(
                              width: 72.0,
                              height: 72.0,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  image: AssetImage('images/card-image.jpg'),
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              SizedBox(height: 10),
                              Text(
                                '$name',
                                style: GoogleFonts.alatsi(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 25,
                                    color: Colors.black),
                              ),
                              Text(
                                'Buszze mobile card',
                                style: GoogleFonts.alatsi(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15,
                                    color: Colors.black),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    FlipCard(
                      direction: FlipDirection.HORIZONTAL,
                      front: Container(
                        height: 240.0,
                        padding: EdgeInsets.all(10),
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          elevation: 20.0,
                          color: Colors.white,
                          child: Padding(
                            padding: EdgeInsets.all(20.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                //part 1:image and name
                                Row(
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        //image

                                        //text widget

                                        Container(
                                          child: Column(
                                            children: [
                                              Row(
                                                children: [
                                                  Text(
                                                    'My Balance :',
                                                    style: GoogleFonts.alatsi(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 20,
                                                        color: Colors.black),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(height: 10),
                                              Row(
                                                children: [
                                                  Text(
                                                    ' S\$' '$amount',
                                                    style: GoogleFonts.alatsi(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 50,
                                                        color: Colors.black),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),

                                //part2:contact info
                                SizedBox(height: 28.0),
                                //part3:icons
                                SizedBox(height: 5.0),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: <Widget>[
                                    Icon(Icons.card_giftcard),
                                    Icon(Icons.money),
                                    Icon(Icons.phone_android),
                                    Icon(Icons.phone_iphone),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      back: Container(
                        height: 240.0,
                        padding: EdgeInsets.all(10),
                        child: Card(
                          elevation: 5.0,
                          color: Colors.white,
                          child: Padding(
                            padding: EdgeInsets.all(20.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Icon(Icons.card_membership),
                                        Icon(Icons.bar_chart_rounded),

                                        //text widget
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(height: 28.0),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                      '1234 5678 9101 1121',
                                      style:
                                          Theme.of(context).textTheme.headline6,
                                    ),
                                    Text(
                                      'EXPIRY 09/22',
                                      style:
                                          Theme.of(context).textTheme.subtitle2,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: 380,
                      decoration: new BoxDecoration(
                        borderRadius: new BorderRadius.circular(16.0),
                        color: Colors.orangeAccent,
                      ),
                      child: ListTile(
                        leading: Icon(Icons.add_circle_outline),
                        title: Text(
                          'TOP UP YOUR CARD',
                          style: GoogleFonts.alef(
                              fontSize: 18,
                              fontWeight: FontWeight.w800,
                              color: Colors.white),
                        ),
                        onTap: () => _showTopUpScreen(),
                      ),
                    ),
                    // ListTile(
                    //   leading: Icon(Icons.add_circle_outline),
                    //   title: Text('Update Card Details'),
                    //   onTap: () => _showUpdateScreen(),
                    // ),
                  ],
                ),
              ),
            );
          } else {
            return Loading();
          }
        });
  }
}
