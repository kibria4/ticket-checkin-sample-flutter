import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import './screens/loading.dart';
import './screens/login.dart';
import './screens/eventslist.dart';
import './screens/eventstats.dart';
import './screens/userview.dart';

void main() {
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  runApp(new MaterialApp(
    debugShowCheckedModeBanner: false,
    // home: new LoadingPage(),
    initialRoute: "/",
    routes: {
      "/": (context) => new LoadingScreen(),
      "/login": (context) => new LoginScreen(),
      "/eventlist": (context) => new EventsListScreen(null),
      "/userview": (context) => new UserViewScreen(null),
      "/eventstats": (context) => new EventStatsScreen(),
    },
  ));
}