import 'package:flutter/material.dart';
import 'package:flutter_app/firebase_utils.dart';
import 'package:flutter_app/utils.dart';

class Configure extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ConfigureState();
  }
}

class _ConfigureState extends State<Configure> {
  final List<TextEditingController> _textControllerNameList = List.empty(growable: true);
  final List<TextEditingController> _textControllerIPList = List.empty(growable: true);

  late final Future<List<ControlObject>> _getControjObjectFuture;
  late List<ControlObject> _controlObjects;

  bool _firstLoad = true;

  @override
  void initState() {
    super.initState();

    _getControjObjectFuture = getActuators();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: const Text('Configure'),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => Navigator.of(context).pop(),
            ),
            actions: [
              PopupMenuButton(
                onSelected: (value) {
                  if (value == 1) {
                    // Save the new values
                    for (var i = 0; i < _controlObjects.length; i++) {
                      _controlObjects[i].name = _textControllerNameList[i].text;
                      _controlObjects[i].ip = _textControllerIPList[i].text;
                    }

                    // Push to the database
                    saveControlObjects(_controlObjects, "actuators").then((value) => {
                      if (value) {
                        // Saved successfully, close the page
                        Navigator.of(context).pop()
                      } else {
                        showAlertDialog("Error saving...", "", "Okay", context)
                      }
                    });
                  } else if (value == 2) {
                    setState(() {
                      _controlObjects.add(ControlObject("", _controlObjects.length.toString(), Icons.light, ""));
                      _textControllerNameList.add(TextEditingController(text: ""));
                      _textControllerIPList.add(TextEditingController(text: ""));
                    });
                  }
                },
                itemBuilder: (context) => const [
                  PopupMenuItem(
                    value: 1,
                    child: Text("Save"),
                  ),
                  PopupMenuItem(
                    value: 2,
                    child: Text("Add Actuator"),
                  )
                ])
            ],
          ),
          body: FutureBuilder<List<ControlObject>>(
            future: _getControjObjectFuture,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return errorPage(snapshot.error?.toString() ?? "unknown");
              } else if (snapshot.hasData) {
                // Only set up the control objects on the first load.
                if (_firstLoad) {
                  _controlObjects = snapshot.data ?? List.empty();

                  // Build the text edit controllers
                  for (var element in _controlObjects) {
                    _textControllerNameList.add(TextEditingController(text: element.name));
                    _textControllerIPList.add(TextEditingController(text: element.ip));
                  }

                  _firstLoad = false;
                }

                return ListView.builder(
                  itemCount: _controlObjects.length,
                  itemBuilder: (BuildContext context, int i) {
                    return Card(
                      child: ListTile(
                        title: Column(
                          children: [
                            TextField(
                              decoration: const InputDecoration(labelText: "Name"),
                              controller: _textControllerNameList[i],
                            ),
                            TextField(
                              decoration: const InputDecoration(labelText: "IP"),
                              controller: _textControllerIPList[i],
                            ),
                          ],
                        ),
                        leading: Icon(_controlObjects[i].icon),
                      ),
                    );
                  },
                );
              } else {
                return loadingPage();
              }
            },
          )),
    );
  }
}
