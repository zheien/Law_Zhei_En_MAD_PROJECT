import 'package:flutter/material.dart';

class About extends StatelessWidget {
  final Function onTap;
  About({this.onTap});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 610,
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.greenAccent, Colors.tealAccent[400]]),
      ),
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              width: 400.0,
              height: 230.0,
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                image: DecorationImage(
                  image: AssetImage('images/about.jpg'),
                  fit: BoxFit.contain,
                ),
                //color: Colors.red,
              ),
            ),
          ),
          Text(
            'About Us',
            style: Theme.of(context).textTheme.headline3,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 250,
              decoration: new BoxDecoration(
                color: Colors.white,
                borderRadius: new BorderRadius.circular(16.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    Text(
                      'With Bussze, you can use your contactless bank cards, paynow or paylah to top up the in-app mobile wallet immediately for bus fare payments.',
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    SizedBox(height: 10),
                    Text(
                      'You will no longer have to make upfront top-ups or carry a separate travel card, and your bus fares will be processed and charged to your in-app mobile wallet directly.',
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      // color: Colors.purple[50],
    );
  }
}
