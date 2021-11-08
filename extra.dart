import 'package:flutter/material.dart';
import 'package:flutter_app/question.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  var _questionIndex = 0;

  void answerQuestion() {
    setState(() {
      _questionIndex = _questionIndex + 1;
    });
    print(_questionIndex);
  }

  @override
  Widget build(BuildContext context) {
    var questions = [
      'what\'s your fav colour?',
      'what\'s your favorite animal?',
    ];
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('My First App'),
        ),
        body: Column(
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'username',
                ),
              ),
            ),
            Question(
              questions[_questionIndex],
            ),
            ElevatedButton(
              child: Text('ans1'),
              onPressed: answerQuestion,
            ),
            ElevatedButton(
              child: Text('ans1'),
              onPressed: () => print('Answer 2 chosen'),
            ),
            ElevatedButton(
              child: Text('ans2'),
              onPressed: null,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: TextFormField(
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText:'username',
                ),
              ),
            ),
          ],

        ),
      ),
    );
  }
}



/*
const Padding(
              padding: EdgeInsets.fromLTRB(4,4,4,8),
              //symmetric(horizontal: 8, vertical: 16),
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'email',
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'password',
                ),
              ),
            ),

 */

/*

GestureDetector(
  onTap: () {}, // handle your image tap here
  child: Image.asset(
    'assets/cat.jpg',
    fit: BoxFit.cover, // this is the solution for border
    width: 110.0,
    height: 110.0,
  ),
)
 */

/*
InkWell(
  onTap: () {}, // Handle your callback.
  splashColor: Colors.brown.withOpacity(0.5),
  child: Ink(
    height: 100,
    width: 100,
    decoration: BoxDecoration(
      image: DecorationImage(
        image: AssetImage('your_image_asset'),
        fit: BoxFit.cover,
      ),
    ),
  ),
)
 */