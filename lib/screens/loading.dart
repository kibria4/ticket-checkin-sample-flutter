import 'dart:async';
import 'package:flutter/material.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {

  @override
  void initState(){
    super.initState();

    //Navigator.pushNamedAndRemoveUntil(context, "/acceptance", (Route route) => route = null)

     //Navigator.of(context).pushAndRemoveUntil(new MaterialPageRoute(builder: (BuildContext context) => new AcceptancePage()), (Route route) => route == null));
    Timer(Duration(seconds: 3), () => Navigator.pushNamedAndRemoveUntil(context, "/login", (Route<dynamic> route) => false));
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
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
                flex: 2,
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image.asset(
                        'images/logo.png',
                        width: 175.0,
                        height: 175.0,
                        // color: Colors.redAccent
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10.0),
                      ),
                      // Text(
                      //   "RIPPED GYM"
                      // )
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Color(0xff3e3986)),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 20.0),
                    ),
                    // Text(
                    //   "Loading",
                    //   textAlign: TextAlign.center,
                    //   style: TextStyle(
                    //       fontWeight: FontWeight.bold,
                    //       fontSize: 18.0,
                    //       color: Colors.white),
                    // )
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}