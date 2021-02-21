import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

class Contacts extends StatefulWidget {
  @override
  _ContactsState createState() => _ContactsState();
}

class _ContactsState extends State<Contacts> {
  Query _ref;
  DatabaseReference reference =
      FirebaseDatabase.instance.reference().child('value');
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _ref = FirebaseDatabase.instance
        .reference()
        .child('value')
        .orderByChild('ServiceNo');
  }

  Widget _buildContactItem({Map contact}) {
    // var a = 'test';
    // bool b = false;

    // while (b = true) {
    //   a = contact['ServiceNo'];
    //   if (a = contact['ServiceNo']) {
    //     print(a);
    //   }
    //}
    //Color typeColor = getTypeColor(contact['type']);
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.all(10),
      height: 130,
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.bus_alert,
                color: Theme.of(context).primaryColor,
                size: 20,
              ),
              SizedBox(
                width: 6,
              ),
              Text(
                contact['ServiceNo'],
                style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.w600),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Icon(
                Icons.phone_iphone,
                color: Theme.of(context).accentColor,
                size: 20,
              ),
              SizedBox(
                width: 6,
              ),
              Text(
                contact['Operator'],
                style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).accentColor,
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(width: 15),
              Icon(
                Icons.group_work,
                //color: typeColor,
                size: 20,
              ),
              SizedBox(
                width: 6,
              ),
              Text(
                contact['Category'],
                style: TextStyle(
                    fontSize: 16,
                    //color: typeColor,
                    fontWeight: FontWeight.w600),
              ),
            ],
          ),
          SizedBox(
            height: 15,
          ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.end,
          //   children: [
          //     GestureDetector(
          //       onTap: () {
          //         Navigator.push(
          //             context,
          //             MaterialPageRoute(
          //                 builder: (_) => EditContact(
          //                       contactKey: contact['key'],
          //                     )));
          //       },
          //       child: Row(
          //         children: [
          //           Icon(
          //             Icons.edit,
          //             color: Theme.of(context).primaryColor,
          //           ),
          //           SizedBox(
          //             width: 6,
          //           ),
          //           Text('Edit',
          //               style: TextStyle(
          //                   fontSize: 16,
          //                   color: Theme.of(context).primaryColor,
          //                   fontWeight: FontWeight.w600)),
          //         ],
          //       ),
          //     ),
          //     SizedBox(
          //       width: 20,
          //     ),
          //     GestureDetector(
          //       onTap: () {
          //         _showDeleteDialog(contact: contact);
          //       },
          //       child: Row(
          //         children: [
          //           Icon(
          //             Icons.delete,
          //             color: Colors.red[700],
          //           ),
          //           SizedBox(
          //             width: 6,
          //           ),
          //           Text('Delete',
          //               style: TextStyle(
          //                   fontSize: 16,
          //                   color: Colors.red[700],
          //                   fontWeight: FontWeight.w600)),
          //         ],
          //       ),
          //     ),
          //     SizedBox(
          //       width: 20,
          //     ),
          //   ],
          // )
        ],
      ),
    );
  }

  _showDeleteDialog({Map contact}) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Delete ${contact['name']}'),
            content: Text('Are you sure you want to delete?'),
            actions: [
              FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Cancel')),
              FlatButton(
                  onPressed: () {
                    reference
                        .child(contact['key'])
                        .remove()
                        .whenComplete(() => Navigator.pop(context));
                  },
                  child: Text('Delete'))
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bus Services'),
      ),
      body: Container(
        height: double.infinity,
        child: FirebaseAnimatedList(
          query: _ref,
          itemBuilder: (BuildContext context, DataSnapshot snapshot,
              Animation<double> animation, int index) {
            Map contact = snapshot.value;
            contact['key'] = snapshot.key;
            return _buildContactItem(contact: contact);
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) {
              //return AddContacts();
            }),
          );
        },
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Color getTypeColor(String type) {
    Color color = Theme.of(context).accentColor;

    if (type == 'Work') {
      color = Colors.brown;
    }

    if (type == 'Family') {
      color = Colors.green;
    }

    if (type == 'Friends') {
      color = Colors.teal;
    }
    return color;
  }
}
