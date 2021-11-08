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
        appBar: AppBar(
          title: Text('Smart Home'),
        ),
        body: Column(
          children: <Widget>[
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (context) => new Login()));
                    }, // Handle your callback.
                    splashColor: Colors.brown.withOpacity(0.5),
                    child: Ink(
                      height: 180,
                      width: 180,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/configure.jpg'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (context) => new Login()));
                    }, // Handle your callback.
                    splashColor: Colors.brown.withOpacity(0.5),
                    child: Ink(
                      height: 180,
                      width: 180,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/control.jpg'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
              ]
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            new MaterialPageRoute(
                                builder: (context) => new Login()));
                      }, // Handle your callback.
                      splashColor: Colors.brown.withOpacity(0.5),
                      child: Ink(
                        height: 180,
                        width: 180,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/history.jpg'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            new MaterialPageRoute(
                                builder: (context) => new Login()));
                      }, // Handle your callback.
                      splashColor: Colors.brown.withOpacity(0.5),
                      child: Ink(
                        height: 180,
                        width: 180,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/user.jpg'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                ]
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            new MaterialPageRoute(
                                builder: (context) => new Login()));
                      }, // Handle your callback.
                      splashColor: Colors.brown.withOpacity(0.5),
                      child: Ink(
                        height: 180,
                        width: 180,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/hand.jpg'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            new MaterialPageRoute(
                                builder: (context) => new Login()));
                      }, // Handle your callback.
                      splashColor: Colors.brown.withOpacity(0.5),
                      child: Ink(
                        height: 180,
                        width: 180,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/configure.jpg'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                ]
            ),
          ],
        ),
      ),
    );
  }
}
