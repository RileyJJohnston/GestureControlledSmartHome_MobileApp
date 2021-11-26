

import 'package:flutter/material.dart';

AlertDialog showAlertDialog(String title, String message, String approve, BuildContext context) {
  return AlertDialog(
    title: Text(title),
    content: SingleChildScrollView(
      child: Text(message)
    ),
    actions: <Widget>[
      TextButton(
        child: Text(approve),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
    ],
  );
}