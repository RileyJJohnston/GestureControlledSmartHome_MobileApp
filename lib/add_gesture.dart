import 'package:flutter/material.dart';
import 'package:flutter_app/login.dart';
import 'package:flutter_app/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as _firebase_storage;
import 'dart:io';

String _gestureName = "";
String _password = "";
String dropDownValue = 'One';
//var items = ['1','2','3','4','5','6'];
bool _isImageSelected = false;
PickedFile? _imageFile;

Future uploadImageToFirebase(BuildContext context) async {
  String _fileName = "gesture_" + _gestureName.replaceAll('.', '').replaceAll(' ', '');
  _firebase_storage.Reference ref =
  _firebase_storage.FirebaseStorage.instance
      .ref().child('gesturePictures').child('/$_fileName');

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

class AddGesture extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AddGestureState();
  }
}

class _AddGestureState extends State<AddGesture> {
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

  void _submit() async {
    //TODO: Add photo to Firebase and add the new gesture to the realtime database
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Add Gesture'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
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
                "Add new gesture",
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
                keyboardType: TextInputType.text,
                onChanged: (value) {
                  _gestureName = value;
                },
                textAlign: TextAlign.left,
                decoration: InputDecoration(
                  //decoration: kTextFieldDecoration.copyWith(
                  hintText: 'Gesture Name',
                  prefixIcon: Icon(
                    Icons.short_text,
                    color: Colors.black,
                  ),
                ),
                //prefixIcon: Icon(
                //Icons.email,
                //color: Colors.black,
                //),
              ),
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                    child: Text('Select Actuator', style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      backgroundColor: null,
                      fontWeight: FontWeight.w300,
                    )),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                      child: DropdownButton<String>(
                      value: dropDownValue,
                      icon: const Icon(Icons.keyboard_arrow_down),
                      iconSize: 24,
                      elevation: 16,
                      style: const TextStyle(color: Colors.black,fontWeight: FontWeight.bold),
                      underline: Container(
                        height: 2,
                        color: Colors.black,
                      ),
                      onChanged: (String? newValue) {
                        setState(() {
                          dropDownValue = newValue!;
                        });
                      },
                      items: <String>['One', 'Two', 'Free', 'Four']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                ],
            ),

            ElevatedButton(
              child: Text('Submit'),
              onPressed: _submit,
            ),
          ],
        ),
      ),
    );
  }
}
