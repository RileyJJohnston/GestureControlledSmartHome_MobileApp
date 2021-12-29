
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

Future<String> getAssociatedGesture(List<GestureObject> gestureList, String actuatorName) async {
  for (int i=0; i<gestureList.length; i++) {
    if (gestureList[i].associatedActuator == actuatorName){
      return gestureList[i].name;
    }
  }
  return "None";
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
Future<bool> removeActuator(int index, int length) async{
  try {
    // Connect to the database and get the correct path
    FirebaseDatabase db = FirebaseDatabase(app: Firebase.apps.first);
    final reference = db.reference().child(
        'user:${FirebaseAuth.instance.currentUser?.email?.replaceAll('.', '')}/actuators');

    reference.child(index.toString()).remove();
    for (int i=index+1; i<length; i++){
      reference.child((i-1).toString()).child("name").set(reference.child((i).toString()).child("name"));
      reference.child((i-1).toString()).child("ip").set(reference.child((i).toString()).child("ip"));
    }
    reference.child(length.toString()).remove();
    return true;
  } on Exception catch (_, e) {
    log(e.toString());
    return false;
  }
}

Future<bool> setAssociatedActuator(List<Map<String,String>> _associatedActuators) async {
  try {
    // Connect to the database and get the correct path
    FirebaseDatabase db = FirebaseDatabase(app: Firebase.apps.first);
    final reference = db.reference().child(
        'user:${FirebaseAuth.instance.currentUser?.email?.replaceAll('.', '')}/gestures');


    // Update the values in the database for the user
    for (var i = 0; i < _associatedActuators.length; i++) {
      for (var j = 0; j < _associatedActuators.length; j++) {
        if (reference.child(i.toString()).child("gestureName") == _associatedActuators[j][reference.child(i.toString()).child("gesture")]){
          reference.child(i.toString()).child("gestureName").set(_associatedActuators[j][reference.child(i.toString()).child("actuatorName")]);
        }
      }
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