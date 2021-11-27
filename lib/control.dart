import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/utils.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:collection/collection.dart';


class Control extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return _ControlState();
  }
}

class _ControlState extends State<Control> {

  late final MqttServerClient _client;
  bool _connected = false;

  @override
  void initState() {
    super.initState();

    _connectMqtt();
  }

  void _connectMqtt() async {
    // Create the client object
    _client = MqttServerClient('f51bc650a9c24db18f2b2d13134a6da1.s1.eu.hivemq.cloud', 'flutter_client');
    _client.secure = true;
    _client.port = 8883;
    _client.onConnected = _onConnected;

    // Attempt to connect to the server
    log("Start connect");
    try {
      await _client.connect("testing", "Abc12345");
    } on Exception catch (e) {
      log('Client exception - $e');
      _client.disconnect();
    }

    if (_client.connectionStatus!.state == MqttConnectionState.connected) {
      log('Client connected to the broker');
    } else {
      log('Client connection failed - disconnecting, state is ${_client.connectionStatus!.state}');
      _client.disconnect();
      return;
    }
  }

  void _publishMessage(id) async {
    if (_connected) {
      const String topic = 'gestures/gesture1';
      final builder = MqttClientPayloadBuilder();
      builder.addString(id);
      log('PUBLISH: ' + id);
      _client.publishMessage(topic, MqttQos.atLeastOnce, builder.payload!);

      // Show a message saying that it was posted
      showDialog(context: context, builder: (context) => showAlertDialog("Published", "Topic: $topic\nPayload: $id", "Okay", context));
    } else {
      showDialog(context: context, builder: (context) => showAlertDialog("Not connected", "Has not connected to MQTT broker yet", "Continue", context));
    }
  }

  void _onConnected() async {
    log("Connected");
    _connected = true;
  }

  Future<List<_ControlObject>> _getControlObjects() async {
    final controlObjects = List<_ControlObject>.empty(growable: true);

    // Connect to the database and get the correct path
    FirebaseDatabase db = FirebaseDatabase(app: Firebase.apps.first);
    final reference = db.reference().child('gestures/user:${FirebaseAuth.instance.currentUser?.email?.replaceAll('.', '')}');
    final snapshot = await reference.get();

    // Create the control objects from the list
    if (snapshot.value is List) {
      (snapshot.value as List).forEachIndexed((index, gesture) =>
        controlObjects.add(_ControlObject(gesture['name'].toString(), index.toString(), gestureIconMap[gesture['icon'].toString()] ?? Icons.light))
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

  final List<_ControlObject> _controlObjects = [
    _ControlObject("Lights", "1", Icons.light),
    _ControlObject("Door", "2", Icons.sensor_door),
    _ControlObject("Blinds", "3", Icons.sensor_window),
    _ControlObject("Vacuum", "4", Icons.stop_circle),
    _ControlObject("Make Coffee", "5", Icons.coffee),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Control'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.of(context).pop(),
          )
        ),
        body: FutureBuilder<List<_ControlObject>>(
          future: _getControlObjects(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(child: Text("Error ${snapshot.error}"),);
            } else if (snapshot.hasData) {
              final controlObjects = snapshot.data ?? List.empty();
              return ListView.builder(
                itemCount: controlObjects.length,
                itemBuilder: (BuildContext context, int i) {
                  return Card(
                    child: ListTile(
                      title: Text(controlObjects[i].name),
                      leading: Icon(controlObjects[i].icon),
                      onTap: () => _publishMessage(controlObjects[i].id),
                    ),
                  );
                },
              );
            } else {
              return const Center(child: Text("Loading..."),);
            }
          },
        )
      ),
    );
  }
}

class _ControlObject {
  final String name;
  final String id;
  final IconData icon;

  _ControlObject(this.name, this.id, this.icon);
}
