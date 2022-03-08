
import 'dart:developer';

import 'package:collection/src/iterable_extensions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

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
    print("invoked");
    print(snapshot.value);
    print(snapshot.value.runtimeType);

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

//TODO: Test that this function clears history (events db)
void deleteEvents() async {
  final gestureObjects = List<GestureObject>.empty(growable: true);

  // Connect to the database and get the correct path
  FirebaseDatabase db = FirebaseDatabase(app: Firebase.apps.first);
  final reference = db.reference().child(
      '/user:${FirebaseAuth.instance.currentUser?.email?.replaceAll(
          '.', '')}/' + "events");
  final snapshot = await reference.remove();
}

Future<List<HistoryObject>> fetchHistory(int startIndex, int endIndex) async {
  final historyObjects = List<HistoryObject>.empty(growable: true);

  // Connect to the database and get the correct path
  FirebaseDatabase db = FirebaseDatabase(app: Firebase.apps.first);
  final reference = db.reference().child(
      '/user:${FirebaseAuth.instance.currentUser?.email?.replaceAll(
          '.', '')}/' + "events");
  final snapshot = await reference.get();
  // Create the Gesture objects from the list
  print(snapshot);

  //print("invoked");
  print("snapshot");
  print(snapshot.value);
  print(snapshot.value.runtimeType);

  //final jsonData = jsonDecode('{"yes":2}');
  //print(jsonData["yes"]);

  //print("%%%%%%%%%%%%%");
  //print(jsonEncode(snapshot.value));
  //final jsonData2 = jsonDecode(jsonEncode(snapshot.value));
  //print(jsonData2);

  print("start debug");
  //String test = json.encode({"-Mx-shGlZw7duJ0g3A9S": {"ip": "168.192.0.20", "actuatorName": "doorLock", "timestamp": "Mon Feb 28 10:11:21 2022"}, "no": "{no: yes}", "-Mx-wWymCoeRB4-uF81m": {"ip": "10.0.2.6", "actuatorName": "blinds", "timestamp": "Mon Feb 28 10:28:03 2022"}});
  //test = snapshot.value.toString();
  //print(test);
  //print(json.encode(json.decode(test).runtimeType));
  //print(json.decode(test));
  //print(json.decode(test).runtimeType);
  //print("######################");
  List<Object> snapshotList = [];
  //print(jsonDecode(jsonEncode(snapshot.value)));
  /*(Map<String, dynamic>.from(jsonDecode(jsonEncode(snapshot.value))).values.forEach((str) {
    List<Object> lst = [];
    lst.add(str['ip'].toString());
    //print("YES");
    //print(str.toString());
    //print(str['ip']);
    //print(str['actuatorName']);
    //print(str['timestamp']);
    lst.add(str['actuatorName'].toString());
    lst.add(str['timestamp'].toString());
    snapshotList.add(lst);
  }));*/
  //List<Object>? lst = json.decode(test);//"{-Mx-shGlZw7duJ0g3A9S: {ip: 168.192.0.20, actuatorName: doorLock, timestamp: Mon Feb 28 10:11:21 2022}, no: {no: yes}}");//
  //print("done");
  //lst = snapshot.value.toString() != null ? List.from(jsonDecode(test)) : null;
  //lst;
  //print(lst);
  //print(lst.runtimeType);
  //print("2");
  //print(lst[0].runtimeType);
  //print("2");
  print("start");
  print(startIndex);
  print(endIndex);
  if (snapshot.value is List) {
    print("in");
    (snapshot.value as List).forEachIndexed((index, event) {
      print("list");
      print(event);
      print(event[1]);
      print(event[2]);
      //print("event: " + jsonEncode(event).toString());
      //print("event: " + json.encode(event).toString());
      print('/user:${FirebaseAuth.instance.currentUser?.email?.replaceAll(
          '.', '')}/' + "events");
      List<Object> lst = [];
      (Map<String, dynamic>.from(jsonDecode(jsonEncode(event))).values.forEach((str) => lst.add(str.toString())));
      if (index>=startIndex && index<endIndex){
        //print((json.decode(json.encode(event))).runtimeType);
        //print("TEST: " + jsonDecode(json.encode({1:1}))['ip']);
        //print(event[0]);
        //print(event[1]);
        //print(event[2]);
        //print("done");
        //(Map<String, dynamic>.from(json.decode(event))).values.forEach((str) => ip="sucess");
          historyObjects.add(HistoryObject(
              event['actuatorName'],
              event['ip'],
              event['timestamp']
          ));}
    }
    );
  }
  return historyObjects;
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

class HistoryObject {
  String actuatorName;
  String ip;
  String timestamp;

  HistoryObject(this.actuatorName, this.ip, this.timestamp);
}

class GestureObject {
  String name;
  String id;
  IconData icon;
  String associatedActuator;

  GestureObject(this.name, this.id, this.icon, this.associatedActuator);
}