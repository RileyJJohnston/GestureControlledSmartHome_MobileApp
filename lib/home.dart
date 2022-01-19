import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/login.dart';
import 'package:flutter_app/configure.dart';
import 'package:flutter_app/control.dart';
import 'package:flutter_app/add_user.dart';
import 'package:flutter_app/add_gesture.dart';
import 'package:flutter_app/history.dart';


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
          actions: [
            PopupMenuButton(
              onSelected: (value) {
                if (value == 1) {
                  FirebaseAuth.instance.signOut();
                  Navigator.of(context).pop(MaterialPageRoute(builder: (context) => Login()));
                }
              },
              itemBuilder: (context) => [
                const PopupMenuItem(
                  child: Text("Logout"),
                  value: 1,
                ),
              ]
            )
          ],
        ),
        body: Column(
          children: <Widget>[
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
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
                      height: 165,
                      width: 382,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/configure.jpg'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
                ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
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
                  height: 165,
                  width: 382,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/control.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
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
                        height: 165,
                        width: 382,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/history.jpg'),
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
                    padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
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
                        height: 165,
                        width: 382,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/hand.jpg'),
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
