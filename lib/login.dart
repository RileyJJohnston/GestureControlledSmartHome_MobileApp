import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_app/register.dart';
import 'package:flutter_app/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_app/utils.dart';

String _email = "";
String _password = "";
final _auth = FirebaseAuth.instance;

class Login extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoginState();
  }
}

class _LoginState extends State<Login> {

  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  void _login() async {
    try {
      await _auth.signInWithEmailAndPassword(
          email: _email, password: _password);
      await Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => Home()));
      //ii
    } on FirebaseAuthException catch (e) {
      showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
              title: Text("Whoops! Login Failed"), content: Text('${e.message}')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return _errorPage(snapshot.error);
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          // Check if the user has already logged in, if so replace with main page
          if (FirebaseAuth.instance.currentUser != null) {
            log(FirebaseAuth.instance.currentUser.toString());
            SchedulerBinding.instance!.addPostFrameCallback((_) {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => Home()));
            });
          } else {
            return _loginPage();
          }
        }

        return loadingPage();
      }
    );
  }

  Widget _errorPage(Object? error) {
    return MaterialApp(
      home: Padding(
        padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
        child: Text(error?.toString() ?? "Unknown error")
      )
    );
  }

  Widget _loginPage() {
    return MaterialApp(
      home: Scaffold(
        body: Column(
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.fromLTRB(8, 80, 8, 0),
              child: Text(
                "Smart Home",
                style: TextStyle(fontSize: 28),
                textAlign: TextAlign.center,
              ),
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(8, 8, 8, 80),
              child: Text(
                "Login",
                style: TextStyle(fontSize: 14),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: TextFormField(
                keyboardType: TextInputType.emailAddress,
                onChanged: (value) {
                  _email = value;
                },
                textAlign: TextAlign.left,
                decoration: const InputDecoration(
                  //decoration: kTextFieldDecoration.copyWith(
                  hintText: 'Email',
                  prefixIcon: Icon(
                    Icons.email,
                    color: Colors.black,
                  ),
                ),
                //prefixIcon: Icon(
                //Icons.email,
                //color: Colors.black,
                //),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: TextFormField(
                obscureText: true,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please enter Password";
                  }
                },
                onChanged: (value) {
                  _password = value;
                },
                onFieldSubmitted: (password) => _login(),
                textAlign: TextAlign.left,
                decoration: const InputDecoration(
                    hintText: 'Password',
                    prefixIcon: Icon(
                      Icons.lock,
                      color: Colors.black,
                    )),
              ),
            ),
            ElevatedButton(
              child: const Text('Login'),
              onPressed: _login,
            ),
            TextButton(
                child: Text('Create Account'),
                onPressed: () {
                  Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (context) => new Register()));
                }),
          ],
        ),
      ),
    );
  }
}
