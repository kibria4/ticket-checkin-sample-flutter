import 'package:flutter/material.dart';
import 'package:json_to_form/json_to_form.dart';
import 'dart:convert';

class UserViewScreen extends StatefulWidget {
  final String userName;
  UserViewScreen(this.userName);
  @override
  _UserViewScreenState createState() => _UserViewScreenState();
}

class _UserViewScreenState extends State<UserViewScreen> {
  String form = json.encode([
    {
      'type': 'Switch',
      'title': 'General Admission: Ticket 1',
      'switchValue': false,
    },
    {
      'type': 'Switch',
      'title': 'General Admission: Ticket 2',
      'switchValue': true,
    },
    {
      'type': 'Switch',
      'title': 'General Admission: Ticket 2',
      'switchValue': false,
    },
  ]);
  dynamic response;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff3e3986),
        title: Text(widget.userName),
      ),
      body: Container(
        padding: EdgeInsets.all(32.0),
        child: Center(
          child: Column(
            children: <Widget>[
              new CoreForm(
                form: form,
                onChanged: (dynamic response) {
                  this.response = response;
                },
              ),
              new RaisedButton(
              child: new Text('Confirm'),
              onPressed: () {
                print(this.response.toString());
              })
            ],
          ),
        ),
      ),
    );
  }
}