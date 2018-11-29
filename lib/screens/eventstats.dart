import 'package:flutter/material.dart';

import '../ui/stats_orders_to_download.dart';
import '../ui/stats_orders_to_upload.dart';

class EventStatsScreen extends StatefulWidget {
  @override
  _EventStatsScreenState createState() => _EventStatsScreenState();
}

class _EventStatsScreenState extends State<EventStatsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff3e3986),
        title: Text('Event Stats'),
      ),
      body: Container(
        padding: EdgeInsets.all(32.0),
        child: Center(
          child: Column(
            children: <Widget>[
              Text(
                'Synchronisation',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 10.0),
              ),
              
              UIOrdersToDownload(),
              UIOrdersToUpload(),
              
            ],
          ),
        ),
      ),
    );
  }
}