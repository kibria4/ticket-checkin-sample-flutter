import 'dart:async';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

import 'package:barcode_scan/barcode_scan.dart';

import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import './userview.dart';
import './eventstats.dart';

class EventsListScreen extends StatefulWidget {
  final String eventId;
  EventsListScreen(this.eventId);

  @override
  _EventsListScreenState createState() => _EventsListScreenState();
}

class _EventsListScreenState extends State<EventsListScreen> {
  String barcode = "";
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  Future<String> _barcodeId;


  final TextEditingController _filter = new TextEditingController();
  final dio = new Dio();
  String _searchText = "";
  List names = new List();
  List filteredNames = new List();
  Icon _searchIcon = new Icon(Icons.search);
  Widget _appBarTitle = new Text( 'Event Name' );
  



  _EventsListScreenState() {

    _filter.addListener(() {
      if (_filter.text.isEmpty) {
        setState(() {
          _searchText = "";
          filteredNames = names;
        });
      } else {
        setState(() {
          _searchText = _filter.text;
        });
      }
    });
  }
  
  @override
  void initState() {
    this._getNames();
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildBar(context),
      body: Container(
        child: _buildList(),
      ),
      resizeToAvoidBottomPadding: false,
    );
  }

  Widget _buildBar(BuildContext context) {
    return new AppBar(
      backgroundColor: Color(0xff3e3986),
      centerTitle: true,
      title: _appBarTitle,
      leading: new IconButton(
        icon: _searchIcon,
        onPressed: _searchPressed,
      ),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.scanner),
          onPressed: scan,
        ),
        IconButton(
          icon: Icon(Icons.settings),
          onPressed: () => Navigator.push(context, new MaterialPageRoute(builder: (context) => new EventStatsScreen())),
        ),
      ],
    );
  }

  Widget _buildList() {
    if (!(_searchText.isEmpty)) {
      List tempList = new List();
      for (int i = 0; i < filteredNames.length; i++) {
        if (filteredNames[i]['name'].toLowerCase().contains(_searchText.toLowerCase())) {
          tempList.add(filteredNames[i]);
        }
      }
      filteredNames = tempList;
    }
    return ListView.builder(
      itemCount: names == null ? 0 : filteredNames.length,
      itemBuilder: (BuildContext context, int index) {
        return new ListTile(
          title: Text(filteredNames[index]['name']),
          onTap: () => Navigator.push(context, new MaterialPageRoute(builder: (context) => new UserViewScreen(filteredNames[index]['name']))),
        );
      },
    );
  }

  void _searchPressed() {
    setState(() {
      if (this._searchIcon.icon == Icons.search) {
        this._searchIcon = new Icon(Icons.close);
        this._appBarTitle = new TextField(
          controller: _filter,
          cursorColor: Colors.white,
          style: TextStyle(
            color: Colors.white
          ),
          decoration: new InputDecoration(
            prefixIcon: new Icon(Icons.search),
            hintText: 'Search...',
            hintStyle: TextStyle(
              color: Colors.white,
            ),
            labelStyle: TextStyle(
              color: Colors.white
            ),
            helperStyle: TextStyle(
              color: Colors.white
            ),
            prefixStyle: TextStyle(
              color: Colors.white,
            )
          ),
        );
      } else {
        this._searchIcon = new Icon(Icons.search);
        this._appBarTitle = new Text( 'Search Example' );
        filteredNames = names;
        _filter.clear();
      }
    });
  }

  void _getNames() async {
    final response = await dio.get('https://swapi.co/api/people');
    List tempList = new List();
    for (int i = 0; i < response.data['results'].length; i++) {
      tempList.add(response.data['results'][i]);
    }
    setState(() {
      names = tempList;
      names.shuffle();
      filteredNames = names;
    });
  }

  Future scan() async {
    try {
      String barcode = await BarcodeScanner.scan();
      setState(() => this.barcode = barcode);
      print(barcode);
      final SharedPreferences prefs = await _prefs;
      _barcodeId = prefs.setString("userbarcode", barcode).then((bool success) {
        if(success) {
          // _showDialog("Scanned code: $barcode");
          Navigator.push(context, new MaterialPageRoute(builder: (context) => new UserViewScreen(barcode)));
        }
      });
      
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.CameraAccessDenied) {
        setState(() {
          this.barcode = 'The user did not grant the camera permission!';
        });
      } else {
        setState(() => this.barcode = 'Unknown error: $e');
      }
    } on FormatException{
      setState(() => this.barcode = 'null (User returned using the "back"-button before scanning anything. Result)');
    } catch (e) {
      setState(() => this.barcode = 'Unknown error: $e');
    }
  }

  void _showDialog(String message){
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Message from Code Scanner"),
          content: Text(message),
        );
      },
    );
  }


}