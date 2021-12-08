import 'package:flutter/material.dart';
import 'package:flutter_app/login.dart';

class AddUser extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AddUserState();
  }
}

class _AddUserState extends State<AddUser> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Add User'),
        ),
        body: Column(
          children: <Widget>[

          ],
        ),
      ),
    );
  }
}
