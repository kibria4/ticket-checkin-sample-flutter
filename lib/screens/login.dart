import 'package:flutter/material.dart';

import './eventslist.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}


class _LoginData {
  String eventId = '';
  String password = '';
  String deviceName = '';
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  _LoginData _data = new _LoginData();

  String _validateEventId(String value) {
    if(value.length < 4){
      return 'The Event ID must be at least 4 characters long.';
    }
    return null;
  }

  String _validatePassword(String value) {
    if (value.length < 8) {
      return 'The Password must be at least 8 characters.';
    }

    return null;
  }

  String _validateDeviceName(String value) {
    if(value.length < 4){
      return 'The Device Name must be at least 4 characters long.';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    
    var size = MediaQuery.of(context).size;

    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        backgroundColor: Color(0xff3e3986),
        title: Text('Configure Event'),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(color: Colors.white),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 3,
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      
                      Container(
                        height: (size.height / 1.25),
                        padding: new EdgeInsets.all(5.0),
                        child: new Form(
                          key: this._formKey,
                          child: new ListView(
                            children: <Widget>[
                              Padding (
                                padding: EdgeInsets.only(top: 10.0),
                              ),
                              //Description
                              Text(
                                "Enter your Event ID and Event Password below. You can find this information from your Ticket Tailor control panel by clicking on your event. Go to:",
                                textAlign: TextAlign.center,
                              ),
                              Text(
                                "Attendee check-in > Configure smartphone app",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold
                                ),
                              ),
                              //Event ID (assumed number-based ID)
                              new TextFormField(
                                keyboardType: TextInputType.number, // Use email input type for emails.
                                decoration: new InputDecoration(
                                  hintText: '0912837',
                                  labelText: 'Event ID'
                                ),
                                autocorrect: false,
                                validator: this._validateEventId,
                                onSaved: (String value) {
                                  this._data.eventId = value;
                                },
                                onFieldSubmitted: (String value) {
                                  this._data.eventId = value;
                                }
                              ),
                              //User password
                              new TextFormField(
                                obscureText: true, // Use secure text for passwords.
                                decoration: new InputDecoration(
                                  hintText: 'Password',
                                  labelText: 'Enter your password'
                                ),
                                autocorrect: false,
                                maxLength: 18,
                                validator: this._validatePassword,
                                onSaved: (String value) {
                                  this._data.password = value;
                                },
                                onFieldSubmitted: (String value) {
                                  this._data.password = value;
                                }
                              ),
                              //Device Name for reference
                              new TextFormField(
                                keyboardType: TextInputType.text,
                                decoration: new InputDecoration(
                                  hintText: 'E.g. iPhone 6s',
                                  labelText: 'Device Name'
                                ),
                                autocorrect: false,
                                validator: this._validateDeviceName,
                                onSaved: (String value) {
                                  this._data.deviceName = value;
                                },
                                onFieldSubmitted: (String value) {
                                  this._data.deviceName = value;
                                }
                              ),

                              //Login button
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  new Container(
                                    width: size.width,
                                    child: new RaisedButton(
                                      child: new Text(
                                        'LOGIN',
                                        style: new TextStyle(
                                          color: Colors.white
                                        ),
                                      ),
                                      onPressed: () => Navigator.pushAndRemoveUntil(context, new MaterialPageRoute(builder: (context) => new EventsListScreen(_data.eventId)), (Route route) => route == null),
                                      color: Color(0xff3e3986),
                                    ),
                                    margin: new EdgeInsets.only(
                                      top: 20.0
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: 15.0),
                                  ),
                                  
                                ],
                              )
                              
                            ],
                          ),
                        )
                      ),
                      // Padding(
                      //   padding: EdgeInsets.only(top: 20.0),
                      // ),
                      
                    ],
                  ),
                ),
              ),
              
            ],
          )
        ],
      ),
    );
  }
}