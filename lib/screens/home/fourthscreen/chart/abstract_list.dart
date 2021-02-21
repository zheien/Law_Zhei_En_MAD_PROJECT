import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:project11/models/user.dart';
import 'package:project11/screens/home/fourthscreen/chart/chart_data_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:project11/services/database.dart';
import 'package:http/http.dart' as http;
import 'dart:math';

import 'package:provider/provider.dart';

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
              'http://192.168.68.105/testlocalhost/getData.php?name=$name';
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

                List<Joke> jokes = [];
                for (var joke in snapshot.data["index"]) {
                  Joke newJoke = Joke(
                    joke["date"],
                    joke["price"],
                  );

                  jokes.add(newJoke);
                  print(jokes);
                }

                // return ListView.builder(
                //   itemCount: snap.length,
                //   itemBuilder: (context, index) {
                //     DateTime tempDate = new DateFormat("yyyy-MM-dd hh:mm:ss")
                //         .parse("${snap[index]['dateTime']}");
                //     String date = DateFormat("yyyy-MM-dd hh:mm:ss")
                //         .format(tempDate)
                //         .toString();
                //     // // print(date);
                //     // DateTime dateTime2 =
                //     //     DateTime.parse("${snap[index]['dateTime']}");
                //     print("${snap[index]}");
                //     String bus = "${snap[index]['bus']}".toString();
                //   },
                // );
              }
            },
            future: getMethod(),
          ),
        );
      });
}

abstract class ListItem {
  /// The title line to show in a list item.
  Widget buildTitle(BuildContext context);

  /// The subtitle line, if any, to show in a list item.
  Widget buildChartTitle(BuildContext context);
}

class HeadingItem implements ListItem {
  final String heading;
  static final _random = new Random();

  List<charts.Series<AssessmentRecord, String>> _seriesList;
  HeadingItem(this.heading);

  @override
  Widget buildChartTitle(BuildContext context) {
    // TODO: implement buildChartTitle
    return Container(
      height: 300.0,
      padding: EdgeInsets.all(8.0),
      child: Card(
        child: Column(
          children: <Widget>[
            Expanded(
              child: _displayChart(_createSampleData(), true),
            )
          ],
        ),
      ),
    );
  }

  static int _next(int min, int max) => min + _random.nextInt(max - min);

  @override
  Widget buildTitle(BuildContext context) {
    // TODO: implement buildTitle
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        heading,
        style: Theme.of(context).textTheme.headline,
      ),
    );
  }

  static List<charts.Series<Assessment, String>> _createSampleData() {
    final _formKey = GlobalKey<FormState>();

    // FutureBuilder(
    //   future: getJokes(),
    // );
    List<Joke> jokes;
    print(jokes);
    print('-------------------');

    final assessmentData = [
      new Assessment("01/01", _next(0, 100)),
      new Assessment("02/02", _next(0, 100)),
      new Assessment("03/01", _next(0, 100)),
      new Assessment("04/01", _next(0, 100)),
      new Assessment("05/01", _next(0, 100)),
      new Assessment("06/01", _next(0, 100)),
    ];

    return [
      new charts.Series(
        id: 'Assessment Marks',
        data: assessmentData,
        domainFn: (Assessment assessment, _) => assessment.date,
        measureFn: (Assessment assessment, _) => assessment.price,
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
      )
    ];
  }

  charts.BarChart _displayChart(List<charts.Series> seriesList, bool animate) {
    return new charts.BarChart(
      seriesList,
      animate: animate,
      vertical: true,

      primaryMeasureAxis: new charts.NumericAxisSpec(
        showAxisLine: true,
        renderSpec: charts.GridlineRendererSpec(
            labelStyle: new charts.TextStyleSpec(
              fontSize: 10,
              color: charts.MaterialPalette.white,
            ),
            lineStyle: charts.LineStyleSpec(
              color: charts.MaterialPalette.gray.shadeDefault,
            )),
      ),

      /// This is an OrdinalAxisSpec to match up with BarChart's default
      /// ordinal domain axis (use NumericAxisSpec or DateTimeAxisSpec for
      /// other charts).
      domainAxis: new charts.OrdinalAxisSpec(
        renderSpec: charts.GridlineRendererSpec(
            labelStyle: new charts.TextStyleSpec(
              fontSize: 10,
              color: charts.MaterialPalette.white,
            ),
            lineStyle: charts.LineStyleSpec(
              color: charts.MaterialPalette.gray.shadeDefault,
            )),
      ),
    );
  }
}

class Joke {
  final String date;
  final int price;

  Joke(this.date, this.price);
}
