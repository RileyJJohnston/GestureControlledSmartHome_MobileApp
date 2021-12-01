
import 'package:collection/src/iterable_extensions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Future<List<ControlObject>> getControlObjects() async {
  final controlObjects = List<ControlObject>.empty(growable: true);

  // Connect to the database and get the correct path
  FirebaseDatabase db = FirebaseDatabase(app: Firebase.apps.first);
  final reference = db.reference().child('gestures/user:${FirebaseAuth.instance.currentUser?.email?.replaceAll('.', '')}');
  final snapshot = await reference.get();

  // Create the control objects from the list
  if (snapshot.value is List) {
    (snapshot.value as List).forEachIndexed((index, gesture) =>
        controlObjects.add(ControlObject(gesture['name'].toString(), index.toString(), gestureIconMap[gesture['icon'].toString()] ?? Icons.light))
    );
  }

  return controlObjects;
}

final gestureIconMap = {
  "Light": Icons.light,
  "Door": Icons.sensor_door,
  "Window": Icons.sensor_window,
  "Circle": Icons.stop_circle,
  "Food": Icons.coffee
};

class ControlObject {
  final String name;
  final String id;
  final IconData icon;

  ControlObject(this.name, this.id, this.icon);
}