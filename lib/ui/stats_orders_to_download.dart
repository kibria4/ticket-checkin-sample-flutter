import 'package:flutter/material.dart';

class UIOrdersToDownload extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const ListTile(
            leading: const Icon(Icons.cloud_download),
            title: const Text('Orders to Download', style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          
          new Container(
            width: 50.0,
            height: 50.0,
            padding: EdgeInsets.only(top: 7.5),
            decoration: new BoxDecoration(
              borderRadius: new BorderRadius.circular(25.0),
              border: new Border.all(
                width: 5.0,
                color: Color(0xff3e3986),
              ),
            ),
            child: Text("3", style: TextStyle(fontSize: 20.0, color: Color(0xff3e3986), fontWeight: FontWeight.bold), textAlign: TextAlign.center),
          ),

          ButtonTheme.bar( // make buttons use the appropriate styles for cards
            child: new ButtonBar(
              children: <Widget>[
                new FlatButton(
                  child: const Text('MORE INFO', style: TextStyle(color: Color(0xff3e3986)),),
                  onPressed: () { 
                    
                  },
                ),
                
              ],
            ),
          ),
          
        ],
      ),
    );
  }
}