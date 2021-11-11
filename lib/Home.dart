import 'package:flutter/material.dart';
import 'package:flutter_app/Login.dart';
import 'package:flutter_app/Configure.dart';
import 'package:flutter_app/Control.dart';
import 'package:flutter_app/AddUser.dart';
import 'package:flutter_app/AddGesture.dart';
import 'package:flutter_app/History.dart';


class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {

  @override
  Widget build(BuildContext context) {
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
                              builder: (context) => new Configure()));
                    }, // Handle your callback.
                    splashColor: Colors.brown.withOpacity(0.5),
                    child: Ink(
                      child: Center(
                        child: Text("Configure",
                          style: TextStyle(
                            fontSize: 30,
                            color: Colors.white,
                            backgroundColor: Colors.black.withOpacity(0.1),
                            fontWeight: FontWeight.w700,
                          )
                        ),
                      ),
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
                              builder: (context) => new Control()));
                    }, // Handle your callback.
                    splashColor: Colors.brown.withOpacity(0.5),
                    child: Ink(
                      child: Center(
                        child: Text("Control",
                            style: TextStyle(
                              fontSize: 30,
                              color: Colors.white,
                              backgroundColor: Colors.black,
                              fontWeight: FontWeight.w700,
                            )
                        ),
                      ),
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
                                builder: (context) => new History()));
                      }, // Handle your callback.
                      splashColor: Colors.brown.withOpacity(0.5),
                      child: Ink(
                        child: Center(
                          child: Text("History",
                              style: TextStyle(
                                fontSize: 30,
                                color: Colors.white,
                                backgroundColor: Colors.black.withOpacity(0.1),
                                fontWeight: FontWeight.w700,
                              )
                          ),
                        ),
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
                                builder: (context) => new AddUser()));
                      }, // Handle your callback.
                      splashColor: Colors.brown.withOpacity(0.5),
                      child: Ink(
                        child: Center(
                          child: Text("Add User",
                              style: TextStyle(
                                fontSize: 30,
                                color: Colors.white,
                                backgroundColor: Colors.black.withOpacity(0.1),
                                fontWeight: FontWeight.w700,
                              )
                          ),
                        ),
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
                                builder: (context) => new AddGesture()));
                      }, // Handle your callback.
                      splashColor: Colors.brown.withOpacity(0.5),
                      child: Ink(
                        child: Center(
                          child: Text("Add Gesture",
                              style: TextStyle(
                                fontSize: 30,
                                color: Colors.white,
                                backgroundColor: Colors.black.withOpacity(0.2),
                                fontWeight: FontWeight.w700,
                              )
                          ),
                        ),
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
