import 'package:flutter/material.dart';
import 'package:flutter_app/firebase_utils.dart';
import 'package:flutter_app/utils.dart';
import 'package:collection/collection.dart';

class Configure extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ConfigureState();
  }
}

class _ConfigureState extends State<Configure> {

  final List<TextEditingController> _textControllerNameList = List.empty(growable: true);
  final List<TextEditingController> _textControllerIPList = List.empty(growable: true);
  late final List<ControlObject> _controlObjects;

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
            PopupMenuItem(
              child: const Text(
                "Save",
                style: TextStyle(color: Colors.white, ),
              ),
              onTap: () {
                // Save the new values
                for (var i = 0; i < _controlObjects.length; i++) {
                  _controlObjects[i].name = _textControllerNameList[i].text;
                  _controlObjects[i].ip = _textControllerIPList[i].text;
                }

                // Push to the database
                saveControlObjects(_controlObjects).then((value) => {
                  if (value) {
                    // Saved successfully, close the page
                    Navigator.of(context).pop()
                  } else {
                    showAlertDialog("Error saving...", "", "Okay", context)
                  }
                }
                );
              },
            ),
          ],
        ),
        body: FutureBuilder<List<ControlObject>>(
          future: getControlObjects(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(child: Text("Error ${snapshot.error}"),);
            } else if (snapshot.hasData) {
              _controlObjects = snapshot.data ?? List.empty();

              // Build the text edit controllers
              for (var element in _controlObjects) {
                _textControllerNameList.add(TextEditingController(text: element.name));
                _textControllerIPList.add(TextEditingController(text: element.ip));
              }

              return ListView.builder(
                itemCount: _controlObjects.length,
                itemBuilder: (BuildContext context, int i) {
                  return Card(
                    child: ListTile(
                      title: Column(
                        children: [
                          TextField(
                            decoration: const InputDecoration(
                              labelText: "Name"
                            ),
                            controller: _textControllerNameList[i],
                          ),
                          TextField(
                            decoration: const InputDecoration(
                                labelText: "IP"
                            ),
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
        )
      ),
    );
  }
}
