import 'package:google_fonts/google_fonts.dart';
import 'package:project11/models/user.dart';
import 'package:project11/services/database.dart';
import 'package:project11/shared/constants.dart';
import 'package:project11/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsForm extends StatefulWidget {
  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String> occupations = [
    'student',
    'housewife',
    'working adult',
    'elderly',
    'toddler',
    'no occupation'
  ];

  final List<int> amounts = [10, 20, 30, 40, 50, 60, 70, 80, 90];
  // form values
  String _currentName;
  String _currentOccupations;

  int _currentAmount;

  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context);
    return Container(
      height: 600,
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.greenAccent, Colors.tealAccent[400]]),
      ),
      child: StreamBuilder<UserData>(
          stream: DatabaseService(uid: user.uid).userData,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              UserData userData = snapshot.data;
              return Container(
                // height: 500,
                // color: Colors.red,
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      Text(
                        'Update your Profile settings.',
                        style: GoogleFonts.alatsi(
                            fontWeight: FontWeight.w500, fontSize: 21),
                      ),
                      SizedBox(height: 20.0),
                      TextFormField(
                        initialValue: userData.name,
                        decoration: textInputDecoration,
                        validator: (val) =>
                            val.isEmpty ? 'Please enter a name' : null,
                        onChanged: (val) => setState(() => _currentName = val),
                        // style: TextStyle(backgroundColor: Colors.purple[100]),
                      ),
                      SizedBox(height: 10.0),
                      DropdownButtonFormField(
                        value: _currentOccupations ?? userData.occupations,
                        decoration: textInputDecoration,
                        items: occupations.map((occupation) {
                          return DropdownMenuItem(
                            value: occupation,
                            child: Text('$occupation'),
                          );
                        }).toList(),
                        style: TextStyle(
                            // backgroundColor: Colors.purple[100],
                            color: Colors.black),
                        onChanged: (val) =>
                            setState(() => _currentOccupations = val),
                      ),
                      SizedBox(height: 10.0),
                      SizedBox(height: 10.0),
                      RaisedButton(
                          color: Colors.orangeAccent[400],
                          child: Text(
                            'Update',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.w700),
                          ),
                          onPressed: () async {
                            if (_formKey.currentState.validate()) {
                              await DatabaseService(uid: user.uid)
                                  .updateUserData(
                                      _currentOccupations ??
                                          snapshot.data.occupations,
                                      _currentName ?? snapshot.data.name,
                                      _currentAmount ?? snapshot.data.amount);
                              Navigator.pop(context);
                            }
                          }),
                    ],
                  ),
                ),
              );
            } else {
              return Loading();
            }
          }),
      // color: Colors.purple[50],
    );
  }
}
