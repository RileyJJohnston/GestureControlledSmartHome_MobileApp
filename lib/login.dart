import 'package:flutter/material.dart';
import 'package:flutter_app/register.dart';
import 'package:flutter_app/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

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

  void _goToRegistrationPage() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => Register()));
  }

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
              title: Text("Ops! Login Failed"), content: Text('${e.message}')));
    }
  }

  @override
  Widget build(BuildContext context) {
    Firebase.initializeApp();
    return MaterialApp(
      home: Scaffold(
        body: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 80, 8, 0),
              child: Text(
                "Smart Home",
                style: TextStyle(fontSize: 28),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 8, 8, 80),
              child: Text(
                "Login",
                style: TextStyle(fontSize: 14),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: TextFormField(
                keyboardType: TextInputType.emailAddress,
                onChanged: (value) {
                  _email = value;
                },
                textAlign: TextAlign.left,
                decoration: InputDecoration(
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
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
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
                textAlign: TextAlign.left,
                decoration: InputDecoration(
                    hintText: 'Password',
                    prefixIcon: Icon(
                      Icons.lock,
                      color: Colors.black,
                    )),
              ),
            ),
            ElevatedButton(
              child: Text('Login'),
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
