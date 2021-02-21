import 'package:project11/models/brew.dart';
import 'package:project11/screens/home/brew_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileList extends StatefulWidget {
  @override
  _ProfileListState createState() => _ProfileListState();
}

class _ProfileListState extends State<ProfileList> {
  @override
  Widget build(BuildContext context) {
    final profile = Provider.of<List<Profile>>(context) ?? [];

    return ListView.builder(
      itemCount: profile.length,
      itemBuilder: (context, index) {
        return ProfileTile(profile: profile[index]);
      },
    );
  }
}
