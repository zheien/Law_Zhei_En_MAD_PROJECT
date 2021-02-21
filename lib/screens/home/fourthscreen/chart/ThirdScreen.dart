import 'dart:convert';
import 'package:http/http.dart' as http;
//import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';
import 'package:project11/models/user.dart';
import 'package:project11/services/database.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:project11/screens/home/fourthscreen/chart/chart_data_model.dart';
import 'package:project11/screens/home/fourthscreen/chart/chart_list_page.dart';
import 'package:project11/screens/home/fourthscreen/chart/abstract_list.dart';

void main() => runApp(MyApp2());

class MyApp2 extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Color.fromRGBO(221, 160, 221, 1.0),
        canvasColor: Color.fromRGBO(221, 160, 221, 1.0),
        brightness: Brightness.light,
      ),
      home: ChartListView(
        items: List<ListItem>.generate(
          5,
          (i) => HeadingItem(
            "Transactions $i",
          ),
        ),
      ),
    );
  }
}
