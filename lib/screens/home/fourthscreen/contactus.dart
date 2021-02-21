import 'package:contactus/contactus.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(Contact());
}

class Contact extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.purple[50],
        body: ContactUs(
          logo: AssetImage('images/coffee_icon.png'),
          email: '193133b@mymail.nyp.edu.sg',
          companyName: 'Contact Us',
          phoneNumber: '+6598953668',
          tagLine: 'Buszze',
        ),
      ),
    );
  }
}
