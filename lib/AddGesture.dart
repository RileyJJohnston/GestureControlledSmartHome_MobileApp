import 'package:flutter/material.dart';
import 'package:flutter_app/question.dart';
import 'package:flutter_app/Login.dart';

class AddGesture extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AddGestureState();
  }
}

class _AddGestureState extends State<AddGesture> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Add Gesture'),
        ),
        body: Column(
          children: <Widget>[

          ],
        ),
      ),
    );
  }
}
