

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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Configure'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.of(context).pop(),
          )
        ),
        body: FutureBuilder<List<ControlObject>>(
          future: getControlObjects(),
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
