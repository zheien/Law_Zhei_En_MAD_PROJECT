import 'package:project11/models/brew.dart';
import 'package:flutter/material.dart';

class ProfileTile extends StatelessWidget {
  final Profile profile;
  ProfileTile({this.profile});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
        child: ListTile(
          leading: CircleAvatar(
            radius: 25.0,
            backgroundColor: Colors.blue[profile.strength],
            //backgroundImage: AssetImage('images/coffee_icon.png'),
          ),
          title: Text(profile.name),
          subtitle: Text('Occupation: ${profile.occupations}'),
        ),
      ),
    );
  }
}
