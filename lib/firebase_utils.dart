
import 'dart:developer';

import 'package:collection/src/iterable_extensions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Future<List<ControlObject>> getControlObjects(String databaseName) async {
  final controlObjects = List<ControlObject>.empty(growable: true);

  // Connect to the database and get the correct path
  FirebaseDatabase db = FirebaseDatabase(app: Firebase.apps.first);
  final reference = db.reference().child(
      '/user:${FirebaseAuth.instance.currentUser?.email?.replaceAll(
          '.', '')}/' + databaseName);
  final snapshot = await reference.get();

  // Create the control objects from the list
  if (snapshot.value is List) {
    if (databaseName == "actuators") {
      (snapshot.value as List).forEachIndexed((index, gesture) =>
          controlObjects.add(ControlObject(
              gesture['name'].toString(),
              index.toString(),
              gestureIconMap[gesture['icon'].toString()] ?? Icons.light,
              gesture['ip'] ?? ""
          ))
      );
    } else if (databaseName == "gestures") {
      (snapshot.value as List).forEachIndexed((index, gesture) =>
          controlObjects.add(ControlObject(
              gesture['associatedActuator'].toString(),
              index.toString(),
              gestureIconMap[gesture['icon'].toString()] ?? Icons.light,
              gesture['gestureName'] ?? ""
          ))
      );
    }
  }
  return controlObjects;
}

Future<List<GestureObject>> getGestureObjects(String databaseName) async {
  final gestureObjects = List<GestureObject>.empty(growable: true);

  // Connect to the database and get the correct path
  FirebaseDatabase db = FirebaseDatabase(app: Firebase.apps.first);
  final reference = db.reference().child(
      '/user:${FirebaseAuth.instance.currentUser?.email?.replaceAll(
          '.', '')}/' + databaseName);
  final snapshot = await reference.get();
  print((snapshot.value as List)[1]);
  // Create the Gesture objects from the list
  if (snapshot.value is List) {
      (snapshot.value as List).forEachIndexed((index, gesture) {
          print('/user:${FirebaseAuth.instance.currentUser?.email?.replaceAll(
              '.', '')}/' + databaseName);
          gestureObjects.add(GestureObject(
              gesture['gestureName'].toString(),
              index.toString(),
              gestureIconMap[gesture['icon'].toString()] ?? Icons.light,
              gesture['associatedActuator'] ?? ""
          ));}
      );
  }
  return gestureObjects;
}

Future<bool> saveControlObjects(List<ControlObject> controlObjects, String databaseName) async {
  try {
    // Connect to the database and get the correct path
    FirebaseDatabase db = FirebaseDatabase(app: Firebase.apps.first);
    final reference = db.reference().child(
        'user:${FirebaseAuth.instance.currentUser?.email?.replaceAll('.', '')}/' + databaseName);

    // Update the values in the database for the user
    for (var i = 0; i < controlObjects.length; i++) {
      reference.child(i.toString()).child("name").set(controlObjects[i].name);
      reference.child(i.toString()).child("ip").set(controlObjects[i].ip);
    }

    // Push the changes
    reference.push();

    return true;
  } on Exception catch (_, e) {
    log(e.toString());
    return false;
  }
}

Future<List<ControlObject>> getActuators() async {
  return getControlObjects("actuators");
}

Future<List<GestureObject>> getGestures() async {
  return getGestureObjects("gestures");
}

Future<bool> addGesture(String gestureName, String actuatorName) async {
  try {
    // Connect to the database and get the correct path
    FirebaseDatabase db = FirebaseDatabase(app: Firebase.apps.first);
    final reference = db.reference().child(
        'user:${FirebaseAuth.instance.currentUser?.email?.replaceAll(
            '.', '')}/gestures');

    var list = await getControlObjects("gestures");
    var index = list.length;
    // Update the values in the database for the user
      reference.child(index.toString()).child("gestureName").set(gestureName);
      reference.child(index.toString()).child("associatedActuator").set(actuatorName);
      //reference.child(index.toString()).child("name").set(name);

    // Push the changes
    reference.push();

    return true;
  } on Exception catch (_, e) {
    log(e.toString());
    return false;
  }
}

//Future<bool> saveControlObjects(List<ControlObject> controlObjects, String databaseName) async {
//
//  }

final gestureIconMap = {
  "Light": Icons.light,
  "Door": Icons.sensor_door,
  "Window": Icons.sensor_window,
  "Circle": Icons.stop_circle,
  "Food": Icons.coffee
};

class ControlObject {
  String name;
  String id;
  IconData icon;
  String ip;

  ControlObject(this.name, this.id, this.icon, this.ip);
}

class GestureObject {
  String name;
  String id;
  IconData icon;
  String associatedActuator;

  GestureObject(this.name, this.id, this.icon, this.associatedActuator);
}