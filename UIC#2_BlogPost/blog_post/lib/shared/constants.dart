import 'package:flutter/material.dart';

const kTextInputDecoration = InputDecoration(
  fillColor: Colors.white,
  filled: true,
  contentPadding: EdgeInsets.all(12.0),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.white, width: 2.0),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.pink, width: 2.0),
  ),
);

const kSubtitleTextStyle = TextStyle(
  color: Colors.black54,
);

const kTitleTextStyle = TextStyle(
  fontSize: 16,
);
