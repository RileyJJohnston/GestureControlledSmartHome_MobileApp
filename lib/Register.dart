import 'package:flutter/material.dart';
import 'package:flutter_app/Login.dart';
import 'package:flutter_app/Home.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:path/path.dart' as Path;
import 'package:firebase_storage/firebase_storage.dart' as _firebase_storage;
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as Path;

import 'dart:io';

String _email = "";
String _password = "";
final _auth = FirebaseAuth.instance;

bool _isImageSelected = false;
PickedFile? _imageFile = null;

//FirebaseStorage _firebase_storage = FirebaseStorage.instance;

Future uploadImageToFirebase(BuildContext context) async {
  String _fileName = "test"; //Path.basename(_imageFile!.path);
  _firebase_storage.Reference ref =
  _firebase_storage.FirebaseStorage.instance
      .ref().child('profilePictures').child('/$_fileName');

  print(ref);
  final metadata = _firebase_storage.SettableMetadata(
    contentType: 'image/jpeg',);

  _firebase_storage.UploadTask uploadTask = ref.putFile(
      File(_imageFile!.path), metadata);

  _firebase_storage.UploadTask task= await Future.value(uploadTask);
  Future.value(uploadTask).then((value) => {
    print("Firebase image file path: ${value.ref.fullPath}")
  }).onError((error, stackTrace) => {
    print("Failed to upload profile picture to Firebase ${error.toString()} ")
  });
}

class Register extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return _RegisterState();
  }
}

class _RegisterState extends State<Register> {

  void _uploadPhoto(BuildContext context) async{
    final pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery ,
    );
    setState(() {
      _imageFile = pickedFile!;
    });
  }

  void _takePicture(BuildContext context)  async{
    final pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera ,
    );
    setState(() {
      _imageFile = pickedFile!;
    });
    _isImageSelected = true;
  }

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
      uploadImageToFirebase(context);
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
              padding: const EdgeInsets.fromLTRB(8, 8, 8, 62),
              child: Text(
                "Register new user",
                style: TextStyle(fontSize: 14),
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              child: (_isImageSelected==false || _imageFile == null) ?
              Column(
                children: <Widget>[
                  Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                          child: InkWell(
                            onTap: () {
                              _takePicture(context);
                            }, // Handle your callback.
                            splashColor: Colors.brown.withOpacity(0.5),
                            child: Ink(
                              height: 60,
                              width: 60,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage('assets/open_camera.png'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                          child: InkWell(
                            splashColor: Colors.brown.withOpacity(0.5),
                            child: Ink(
                              child: const Align(
                                alignment: Alignment.centerLeft,
                                child: Text("Take Picture",
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.black,
                                      backgroundColor: null,
                                      fontWeight: FontWeight.w300,
                                    )
                                ),
                              ),
                              height: 50,
                              width: 210,
                            ),
                          ),
                        ),
                      ]
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          child: InkWell(
                            onTap: () {
                              _uploadPhoto(context);
                            }, // Handle your callback.
                            splashColor: Colors.brown.withOpacity(0.5),
                            child: Ink(
                              height: 45,
                              width: 45,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage('assets/upload_image.png'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                          child: InkWell(
                            splashColor: Colors.brown.withOpacity(0.5),
                            child: Ink(
                              child: Center(
                                child: const Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text("Upload Photo",
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.black,
                                        backgroundColor: null,
                                        fontWeight: FontWeight.w300,
                                      )
                                  ),
                                ),
                              ),
                              height: 50,
                              width: 210,
                            ),
                          ),
                        ),
                      ]
                  ),
                ],
              ):
              Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container (
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 5),
                        child: Image.file( File(_imageFile!.path)),
                      ),
                      width: 160,
                      height: 160,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 5),
                      child: TextButton(
                          child: Text('Retake'),
                          onPressed:   () {
                            setState(() {
                              //_imageFile = null;
                              _isImageSelected = false;
                            });
                          }
                      ),
                    ),
                  ]
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(4,32,4,8),
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
