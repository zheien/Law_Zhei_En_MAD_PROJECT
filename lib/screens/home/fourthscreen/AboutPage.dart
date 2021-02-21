import 'package:flutter/material.dart';

class About extends StatelessWidget {
  final Function onTap;
  About({this.onTap});
  @override
  Widget build(BuildContext context) {
    return Container(
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
      color: Colors.purple[50],
    );
  }
}
