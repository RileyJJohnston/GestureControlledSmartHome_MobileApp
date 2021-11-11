import 'package:flutter/material.dart';
import 'package:flutter_app/Login.dart';

class Control extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ControlState();
  }
}

class _ControlState extends State<Control> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Control'),
        ),
        body: Column(
          children: <Widget>[

          ],
        ),
      ),
    );
  }
}
