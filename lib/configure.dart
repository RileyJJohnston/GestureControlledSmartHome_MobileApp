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
  List<String> _associatedGestures = [];
  List<String> _dropDownValue = List.filled(100,"Initial");

  bool _firstLoad = true;
  @override
  void initState() {
    super.initState();

    _getControjObjectFuture = getActuators();
  }

  void _getDropDownValues() async {
    var list = await getGestures();
    List<ControlObject> controlObjects = await _getControjObjectFuture;
    var length = controlObjects.length;
    bool initialRun = false;
    if (_dropDownValue[0] == "Initial"){
      initialRun = true;
    }
    for (var i = 0; i < length; i++) {
      print("i = " + i.toString());
      _dropDownValue[i] = await getAssociatedGesture(list, controlObjects[i].name);
      print(_dropDownValue[i]);
    }
    if (initialRun && (length != 0)){
      setState(() {});
    }
  }

  void _getGestures() async {
    var list = await getGestures();
    _associatedGestures.clear();
    _associatedGestures.add("None");
    if (list.length > 0) {
      //_dropDownValue = "None";
      for (var i = 0; i < list.length; i++) {
        _associatedGestures.add(list[i].name);
        print(list[i].name);
      }
    }
    return;
  }

  @override
  Widget build(BuildContext context) {
    _getGestures();
    _getDropDownValues();
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
                    List<Map<String,String>> _associatedActuators = [];
                    for (var i = 0; i < _controlObjects.length; i++) {
                      Map<String,String> temp_entry = new Map();
                      temp_entry['actuator'] = _textControllerNameList[i].text;
                      temp_entry['gesture'] = _associatedGestures[i];
                      _associatedActuators.add(temp_entry);
                    }
                    setAssociatedActuator(_associatedActuators);
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
                      _dropDownValue.add("None");
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
                //TODO: make each list item deletable (e.g. select trash icon in top right corner of item)
                return ListView.builder(
                  itemCount: _controlObjects.length,
                  itemBuilder: (BuildContext context, int i) {
                    return Card(
                      child: ListTile(
                        title: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Expanded(
                                  flex:7,
                                  child:
                                  TextField(
                                  decoration: const InputDecoration(labelText: "Name"),
                                  controller: _textControllerNameList[i],
                                ),
                                ),
                                Expanded(
                                  flex:1,
                                  child: Padding(
                                    padding: EdgeInsets.fromLTRB(0,0,0,8),
                                    child: IconButton(
                                      icon: const Icon(Icons.delete),
                                      tooltip: 'Delete this actuator',
                                      onPressed: () {
                                        showDialog(
                                            context: context,
                                            builder: (ctx) =>
                                                AlertDialog(
                                                    title:
                                                    Text('Are you sure you want to remove this actuator?'),
                                                    actions: <Widget>[
                                                      FlatButton(child: Text("Yes"),onPressed: () {
                                                        setState(() {
                                                          removeActuator(i, _controlObjects.length);
                                                          _controlObjects.removeAt(i);
                                                          Navigator.of(context, rootNavigator: true).pop();
                                                        });
                                                      }
                                                    ),
                                                      FlatButton(child: Text("No"),onPressed: () {
                                                        Navigator.of(context, rootNavigator: true).pop();
                                                        //Navigator.pop(context);
                                                      }),
                                                  ],)
                                          //content: Text('Are you sure you wish to delete this actuator?')
                                                );
                                        //);
                                        //setState(() {
                                        //  print("deleteMe");
                                        //});
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            TextField(
                              decoration: const InputDecoration(labelText: "IP"),
                              controller: _textControllerIPList[i],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 1, vertical: 16),
                                  child: Text('Select Gesture', style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.black,
                                    backgroundColor: null,
                                    fontWeight: FontWeight.w300,
                                  )),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                                  child: DropdownButton<String>(
                                    value: (_dropDownValue[0] == "Initial")?"None":_dropDownValue[i],
                                    icon: const Icon(Icons.keyboard_arrow_down),
                                    iconSize: 40,
                                    elevation: 16,
                                    style: const TextStyle(color: Colors.black,fontWeight: FontWeight.bold),
                                    underline: Container(
                                      height: 2,
                                      color: Colors.black,
                                    ),
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        _dropDownValue[i] = newValue!;
                                      });
                                      _dropDownValue[i] = newValue!;
                                    },
                                    items: _associatedGestures
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
                          ],
                        ),
                        leading: Icon((_textControllerNameList[i].text.toLowerCase().contains("light"))?Icons.light:
                                      (_textControllerNameList[i].text.toLowerCase().contains("door") || _textControllerNameList[i].text.toLowerCase().contains("lock"))?Icons.lock:
                                      (_textControllerNameList[i].text.toLowerCase().contains("blinds"))?Icons.window:
                                      (_textControllerNameList[i].text.toLowerCase().contains("powerbar") || _textControllerNameList[i].text.toLowerCase().contains("power_bar") || _textControllerNameList[i].text.toLowerCase().contains("plug"))?Icons.electrical_services:Icons.devices
                      ),
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
