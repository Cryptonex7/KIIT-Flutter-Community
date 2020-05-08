import 'dart:async';
import 'dart:convert';

//import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<Album> fetchAlbum() async {
  final response =
      await http.get('https://api.covid19india.org/data.json');

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return Album.fromJson(json.decode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

class Album {
  final int confirmed;
  final String statecode;

  Album({this.confirmed, this.statecode});

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      confirmed: json['statewise'].data['confirmed'],
      statecode: json['statewise'].data['statecode'],
    );
  }
}