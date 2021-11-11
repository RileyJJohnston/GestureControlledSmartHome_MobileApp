import 'package:flutter/material.dart';
import 'package:flutter_app/question.dart';
import 'package:flutter_app/Login.dart';

class History extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HistoryState();
  }
}

class _HistoryState extends State<History> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('History Log'),
        ),
        body: Column(
          children: <Widget>[

          ],
        ),
      ),
    );
  }
}