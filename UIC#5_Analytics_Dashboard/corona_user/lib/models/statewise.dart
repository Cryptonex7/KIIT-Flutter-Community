//import 'package:flutter/material.dart';
//import 'package:intl/intl.dart';

class StateWise{
  
  String active;
  int confirmed;
  int deaths;
  int recovered;
  String state;
  String stateCode;

  StateWise({
    this.active,
    this.confirmed,
    this.deaths,
    this.recovered,
    this.state,
    this.stateCode,
  });

}

class Cases{
  String dailyConfirmed;
  DateTime date;

  Cases({

    this.dailyConfirmed,
    this.date,

  });

}