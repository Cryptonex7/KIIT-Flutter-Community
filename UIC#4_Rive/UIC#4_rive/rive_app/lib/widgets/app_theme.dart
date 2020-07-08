import 'package:flutter/material.dart';
 
class AppTheme {
  //
  AppTheme._();
 
  static final ThemeData lightTheme = ThemeData(
    canvasColor: Color.fromRGBO(255, 254, 229, 1),
    primarySwatch: Colors.purple,
    fontFamily: 'CO',
    textTheme: TextTheme(
      title: TextStyle(
        
        fontSize: 15,
      ),),
 
  );
 
  static final ThemeData darkTheme = ThemeData(
    canvasColor: Colors.black,
    scaffoldBackgroundColor: Colors.black,
    fontFamily: 'CO',
    appBarTheme: AppBarTheme(

      color: Colors.black,
      iconTheme: IconThemeData(
        color: Colors.white,
      ),
    ),
    cardTheme: CardTheme(
      color: Colors.black,
    ),
    iconTheme: IconThemeData(
      color: Colors.white54,
    ),
    textTheme: TextTheme(
      title: TextStyle(
        color: Colors.white,
        fontSize: 15.0,
      ),
      subtitle: TextStyle(
        color: Colors.white70,
        fontSize: 18.0,
      ),
    ),
  );
}