import 'package:flutter/material.dart';
import 'package:flutter_app/login.dart';
import 'package:flutter_app/firebase_utils.dart';

class History extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HistoryState();
  }
}

class _HistoryState extends State<History> {
  ScrollController controller = ScrollController();
  List<HistoryObject> events = [];
  bool initialBuild = true;

  @override
  void initState() {
    super.initState();
    controller = ScrollController()..addListener(_scrollListener);
  }

  @override
  void dispose() {
    controller.removeListener(_scrollListener);
    super.dispose();
  }

  @override
  void _fetchHistory(int startIndex, int endIndex) async {
    List<HistoryObject> eventList = await fetchHistory(startIndex, endIndex);
    //await Future.delayed(Duration(seconds: 5));
    //events.addAll(events);
    print(eventList.length);
    print("!@#!@#!@#!@@#!@#!@@#");
    setState(() {
      events.addAll(eventList);
      initialBuild = false;
    });
  }
  @override
  Widget build(BuildContext context) {
    print("You SHOULD SEE ME ONCE");
    if (initialBuild) {
      _fetchHistory(0, 100);
    }
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
            title: const Text('History'),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => Navigator.of(context).pop(),
            )
        ),
        body: Scrollbar(
          child: ListView.builder(
            controller: controller,
            itemBuilder: (context, index) {
              return
                Container(
                  //constraints: BoxConstraints.expand(
                  //height: Theme.of(context).textTheme.headline4!.fontSize! * 1.1 + 200.0,
              //),
              padding: const EdgeInsets.all(8.0),
              color: (index%2 == 0)?Colors.blue[200]:Colors.blue[100],
              alignment: Alignment.center,
              child: Text.rich(
                TextSpan(
                  text: '', // default text style
                  children: <TextSpan>[
                    TextSpan(text: events[index].actuatorName, style: TextStyle(fontWeight: FontWeight.bold, fontSize:18)),
                    TextSpan(text: " (" + events[index].ip + ") triggered at " + events[index].timestamp, style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
              ));//Text(events[index].actuatorName + " (" + events[index].ip + ") triggered at " + events[index].timestamp,  style: const TextStyle(fontWeight: FontWeight.bold),);
            },
            itemCount: events.length,
          ),
        ),
        ),
    );
  }
  void _scrollListener() {
    print(controller.position.extentAfter);
    if (controller.position.extentAfter < 500) {
      _fetchHistory(events.length, events.length+42);
      //List<HistoryObject> events = await fetchHistory(2,5);
      //setState(() {
        //events.addAll(events);
        //events.addAll(List.generate(42, (index) => 'Inserted $index'));
      //});
    }
  }
}