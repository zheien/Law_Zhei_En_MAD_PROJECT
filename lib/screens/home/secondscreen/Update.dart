import 'package:project11/models/user.dart';
import 'package:project11/services/database.dart';
import 'package:project11/shared/constants.dart';
import 'package:project11/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Update extends StatefulWidget {
  @override
  _UpdateState createState() => _UpdateState();
}

class _UpdateState extends State<Update> {
  bool _checked = false;
  final _formKey = GlobalKey<FormState>();

  final List<int> amounts = [0, 10, 20, 30, 40, 50, 60, 70, 80, 90];
  // form values
  String _currentName;
  String _currentOccupations;

  int _currentAmount;

  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context);
    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserData userData = snapshot.data;
            return Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Text(
                    'Top up your card. \$10 per bar',
                    style: TextStyle(fontSize: 18.0),
                  ),

                  SizedBox(height: 100.0),

                  Slider(
                    value: (_currentAmount ?? 0).toDouble(),
                    activeColor: Colors.blue[_currentAmount ?? userData.amount],
                    inactiveColor:
                        Colors.purple[_currentAmount ?? userData.amount],
                    min: 0,
                    max: 90,
                    divisions: 9,
                    onChanged: (val) =>
                        setState(() => _currentAmount = val.round()),
                  ),

                  // CheckboxListTile(
                  //   title: Text('test'),
                  //   secondary: Icon(Icons.beach_access),
                  //   controlAffinity: ListTileControlAffinity.platform,
                  //   value: _checked,
                  //   onChanged: (bool value) {
                  //     setState(() {
                  //       _checked = value;
                  //       print(value);
                  //     });
                  //   },
                  //   activeColor: Colors.green,
                  //   checkColor: Colors.black,
                  // ),
                  SizedBox(height: 10.0),
                  RaisedButton(
                      color: Colors.purple[100],
                      child: Text(
                        'Update',
                        style: TextStyle(color: Colors.black),
                      ),
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          await DatabaseService(uid: user.uid).updateUserData(
                              _currentOccupations ?? snapshot.data.occupations,
                              _currentName ?? snapshot.data.name,
                              (_currentAmount + snapshot.data.amount) ??
                                  snapshot.data.amount);
                          Navigator.pop(context);
                        }
                      }),
                ],
              ),
            );
          } else {
            return Loading();
          }
        });
  }
}
