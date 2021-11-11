import 'package:flutter/material.dart';
import 'package:flutter_app/Login.dart';

class Configure extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ConfigureState();
  }
}

class _ConfigureState extends State<Configure> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Configure'),
        ),
        body: Column(
          children: <Widget>[

          ],
        ),
      ),
    );
  }
}
