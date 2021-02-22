import 'package:basic_utils/basic_utils.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
//import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:collection/collection.dart';
import 'package:intl/intl.dart';
import 'package:project11/models/user.dart';
import 'package:provider/provider.dart';
import 'package:project11/services/database.dart';

class BusArrival extends StatefulWidget {
  final String value;

  BusArrival({Key key, this.value}) : super(key: key);
  @override
  _BusArrivalState createState() => _BusArrivalState();
}

class _BusArrivalState extends State<BusArrival> {
  //Completer<GoogleMapController> _controller = Completer();
  final _formKey = GlobalKey<FormState>();
  var _textController = new TextEditingController();
  clearTextInput() {
    _textController.clear();
  }

  TextEditingController editingController = TextEditingController();

  String _currentName;
  String _currentOccupations;
  int _currentAmount;
  @override
  Widget build(BuildContext context) {
    String service = 'default';
    String service2;
    return Container(
      height: 480,
      width: 410,
      decoration: BoxDecoration(
        // color: Colors.purple[50],
        gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.greenAccent, Colors.tealAccent[400]]),
      ),
      // color: Colors.purple[50],
      child: Wrap(
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                height: 150,
                width: 420,
                color: Colors.white,
                child: ListView(
                  children: [
                    CarouselSlider(
                      items: [
                        Container(
                          height: 200,
                          // margin: EdgeInsets.all(6.0),
                          // decoration: BoxDecoration(
                          //   borderRadius: BorderRadius.circular(8.0),
                          //   image: DecorationImage(
                          //     image: AssetImage('images/bus-slider-1'),
                          //     fit: BoxFit.cover,
                          //   ),
                          // ),
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('images/bus-slider-1.jpg'),
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                        Container(
                          height: 200,
                          margin: EdgeInsets.all(6.0),
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('images/bus-slider-2.jpg'),
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                        Container(
                          height: 200,
                          margin: EdgeInsets.all(6.0),
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('images/bus-slider-3.jpg'),
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                        Container(
                          height: 250,
                          margin: EdgeInsets.all(6.0),
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('images/bus-slider-4.jpg'),
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ],

                      //Slider Container properties
                      options: CarouselOptions(
                        height: 150.0,
                        enlargeCenterPage: true,
                        autoPlay: true,
                        aspectRatio: 16 / 9,
                        autoPlayCurve: Curves.fastOutSlowIn,
                        enableInfiniteScroll: true,
                        autoPlayAnimationDuration: Duration(milliseconds: 800),
                        viewportFraction: 0.8,
                      ),
                    ),
                  ],
                ),
              ),

              Text(
                'Search For Bus Timings',
                style: GoogleFonts.alatsi(
                  fontWeight: FontWeight.w900,
                  fontSize: 30,
                  //color: Colors.white
                ),
              ),
              // _googlemap(context),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  // onChanged: (value) {
                  //   filterSearchResults(value);
                  // },
                  controller: editingController,
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      labelText: "Enter Bus Stop Number",
                      hintText: "Enter Bus Stop Number",
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(25.0)))),
                ),
              ),
              RaisedButton(
                child: Text(
                  "Search",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
                ),
                textColor: Colors.white,
                color: Colors.orangeAccent,
                onPressed: () {
                  var route = new MaterialPageRoute(
                    builder: (BuildContext context) =>
                        PageTwo(value: editingController.text),
                  );
                  Navigator.of(context).push(route).then((value) {
                    clearTextInput();
                  });
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Widget _googlemap(BuildContext context) {
  //   return Container(
  //     child: GoogleMap(
  //         mapType: MapType.normal,
  //         initialCameraPosition:
  //             CameraPosition(target: LatLng(40.712776, -74.005974), zoom: 12),
  //         onMapCreated: (GoogleMapController controller) {
  //           _controller.complete(controller);
  //         },
  //         markers: {}),
  //   );
  // }
}

class PageTwo extends StatelessWidget {
  final String value;

  PageTwo({Key key, this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String service = 'default';
    String service2;
    return Container(
      height: 480,
      width: 410,
      decoration: BoxDecoration(
        // color: Colors.purple[50],
        gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.greenAccent, Colors.tealAccent[400]]),
      ),
      child: new Scaffold(
        appBar: new AppBar(
          title: new Text("Bus Arrival Timing"),
          backgroundColor: Colors.tealAccent[400],
        ),
        body: Container(
          height: 610,
          width: 410,
          decoration: BoxDecoration(
            // color: Colors.purple[50],
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.greenAccent, Colors.tealAccent[400]]),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
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
                      List snap = snapshot.data;
                      return Container(
                        // color: Colors.blue,
                        child: SizedBox(
                          height: 450,
                          child: ListView.builder(
                            itemCount: snapshot.data.length,
                            itemBuilder: (BuildContext context, int index) {
                              String showDate = Date(
                                  snapshot.data[index].NextBus ??
                                      'No Bus to Show');
                              String showDate2 = Date(
                                  snapshot.data[index].NextBus2 ??
                                      'No Bus to Show');
                              String showDate3 = Date(
                                  snapshot.data[index].NextBus3 ??
                                      'No Bus to Show');
                              for (int i = 0; i < snapshot.data.length; i++) {
                                service = snapshot.data[index].ServiceNo;
                                print(index);
                                print(service);
                                print(snapshot.data);
                                print('-----------------------');
                                //index = index + 1;
                                return Container(
                                  height: 130,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      decoration: new BoxDecoration(
                                        borderRadius:
                                            new BorderRadius.circular(16.0),
                                        color: Colors.white,
                                      ),
                                      child: ListTile(
                                        leading: Icon(Icons.timer_rounded,
                                            color: Colors.blue.shade400,
                                            size: 30.0),
                                        title: Text(
                                          snapshot.data[index].ServiceNo ??
                                              'default value',
                                          style: GoogleFonts.alef(
                                              fontWeight: FontWeight.w700,
                                              fontSize: 25),
                                        ),
                                        subtitle: Wrap(
                                          alignment: WrapAlignment.spaceBetween,
                                          direction: Axis.vertical,
                                          children: <Widget>[
                                            new Text(
                                              "Next Bus : $showDate" ??
                                                  'No Bus to Show',
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 17),
                                            ),
                                            new Text(
                                              "Next Bus : $showDate2" ??
                                                  'No Bus to Show',
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 17),
                                            ),
                                            new Text(
                                              "Next Bus : $showDate3" ??
                                                  'No Bus to Show',
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 17),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }
                            },
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
                RaisedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Back'),
                  color: Colors.orangeAccent,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<List<Joke>> _getJokes() async {
    Map<String, String> headers = {
      "Accept": "application/json",
      "AccountKey": "IIqvBX+MQM2uHovC0RpM9w=="
    };
    String body = "{ 'some':'json'}";

    if ("$value" == "") {
      print('NO INPUT');
    } else {
      var data = await http.get(
          "http://datamall2.mytransport.sg/ltaodataservice/BusArrivalv2?BusStopCode=$value",
          headers: headers);
      var jsonData = json.decode(data.body);
      List<dynamic> data2 = jsonData["Services"];
      List<Joke> jokes = [];
      String count = '0';
      for (var joke in jsonData["Services"]) {
        Joke newJoke = Joke(
            joke["ServiceNo"],
            joke["NextBus"]["EstimatedArrival"] ?? 'No',
            joke["NextBus2"]["EstimatedArrival"] ?? 'No',
            joke["NextBus3"]["EstimatedArrival"] ?? 'No');

        jokes.add(newJoke);
      }

      return jokes;
    }
  }
}

Date(String inputDate) {
  DateTime tempDate =
      new DateFormat("yyyy-MM-dd'T'HH:mm:ss").parse(inputDate) ??
          'No Bus to Show';
  String date = DateFormat("yyyy-MM-dd'T'HH:mm:ss").format(tempDate).toString();
  var parts = date.split('T');
  var prefix = parts[0].trim(); // prefix: "date"
  var date2 = parts.sublist(1).join(':').trim();
  return date2;
}

class Joke {
  final String ServiceNo;
  final String NextBus;
  final String NextBus2;
  final String NextBus3;
  //final String EstimatedArrival;

  Joke(this.ServiceNo, this.NextBus, this.NextBus2, this.NextBus3);
}
