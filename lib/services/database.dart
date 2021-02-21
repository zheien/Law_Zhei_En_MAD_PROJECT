import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project11/models/brew.dart';

import 'package:project11/models/user.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  // collection reference
  final CollectionReference profileCollection =
      Firestore.instance.collection('Profile');

  Future<void> updateUserData(
      String occupations, String name, int amount) async {
    return await profileCollection.document(uid).setData({
      'occupations': occupations,
      'name': name,
      'amount': amount,
    });
  }

  // brew list from snapshot
  List<Profile> _profileListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      //print(doc.data);
      return Profile(
          name: doc.data['name'] ?? '',
          occupations: doc.data['occupations'] ?? 'no occupation',
          amount: doc.data['amount'] ?? 0);
    }).toList();
  }

  // user data from snapshots
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
        uid: uid,
        name: snapshot.data['name'],
        occupations: snapshot.data['occupations'],
        amount: snapshot.data['amount']);
  }

  // get brews stream
  Stream<List<Profile>> get profile {
    return profileCollection.snapshots().map(_profileListFromSnapshot);
  }

  // get user doc stream
  Stream<UserData> get userData {
    return profileCollection
        .document(uid)
        .snapshots()
        .map(_userDataFromSnapshot);
  }
}
