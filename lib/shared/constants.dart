import 'package:flutter/material.dart';

const textInputDecoration = InputDecoration(
  fillColor: Colors.white,
  filled: true,
  contentPadding: EdgeInsets.all(12.0),
  enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.white, width: 2.0),
      borderRadius: BorderRadius.all(Radius.circular(20.0))),
  focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.blue, width: 2.0),
      borderRadius: BorderRadius.all(Radius.circular(20.0))),
);
const textInputDecorationLogin = InputDecoration(
  fillColor: Colors.white,
  filled: true,
  border: InputBorder.none,
  focusedBorder: InputBorder.none,
  enabledBorder: InputBorder.none,
  errorBorder: InputBorder.none,
  disabledBorder: InputBorder.none,
  contentPadding: EdgeInsets.all(10.0),
);
