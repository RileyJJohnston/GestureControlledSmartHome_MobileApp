import 'package:flutter/material.dart';
import 'package:flutter_app/question.dart';
import 'package:flutter_app/Login.dart';

class Home extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {
  var _questionIndex = 0;

  void _submitRegistration() {

  }

  @override
  Widget build(BuildContext context) {
    var questions = [
      'what\'s your fav colour?',
      'what\'s your favorite animal?',
    ];
    return MaterialApp(
      home: Scaffold(
        body: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 80),
              child: Text(
                "Smart Home",
                style: TextStyle(fontSize: 28),
                textAlign: TextAlign.center,
              ),
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(4,4,4,8),
              //symmetric(horizontal: 8, vertical: 16),
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Email',
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(4,4,4,8),
              //symmetric(horizontal: 8, vertical: 16),
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Full Name',
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Password',
                ),
              ),
            ),
            ElevatedButton(
              child: Text('Submit'),
              onPressed: _submitRegistration,
            ),
            TextButton(
                child: Text('Login'),
                onPressed:   () {
                  Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (context) => new Login()));
                }
            ),
          ],

        ),
      ),
    );
  }
}
