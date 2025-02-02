import 'package:flutter/material.dart';

class mytheme{
  ///styles used in the app
  static TextStyle kTempTextStyle = TextStyle(
    fontFamily: 'Spartan MB',
    fontSize: 60.0,
  );
  static TextStyle kMessageTextStyle = TextStyle(
    fontFamily: 'Spartan MB',
    fontSize: 40.0,
  );
  static TextStyle kButtonTextStyle =
  TextStyle(fontSize: 30.0, fontFamily: 'Spartan MB', color:Colors.white);

static  InputDecoration textFieldDecoration = InputDecoration(
      filled: true,
      fillColor: Colors.white,
      icon: Icon(
        Icons.local_activity,
        color:  Colors.white,
      ),
      hintText: 'Enter City name',
      hintStyle: TextStyle(color: Colors.black),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
        borderSide: BorderSide.none,
      ));
}