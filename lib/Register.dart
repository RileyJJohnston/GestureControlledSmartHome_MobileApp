import 'package:flutter/material.dart';
import 'package:flutter_app/Login.dart';
import 'package:flutter_app/Home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

String _email = "";
String _password = "";
final _auth = FirebaseAuth.instance;

class Register extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return _RegisterState();
  }
}

class _RegisterState extends State<Register> {

  void _submitRegistration() async{
    try {
      await _auth.createUserWithEmailAndPassword(
          email: _email, password: _password);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
              'Sucessfully Register.You Can Login Now'),
          duration: Duration(seconds: 5),
        ),
        //duration: Duration(seconds: 5),
      //),
    );
      Navigator.push(
          context,
          new MaterialPageRoute(
              builder: (context) => new Home()));
    } on FirebaseAuthException catch (e) {
      showDialog(
          context: context,
          builder: (ctx) =>
              AlertDialog(
                  title:
                  Text('Registration Failed'),
                  content: Text('${e.message}')
              )
      );
    }
  }

  @override
  Widget build(BuildContext context) {
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
                "Register new user",
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
