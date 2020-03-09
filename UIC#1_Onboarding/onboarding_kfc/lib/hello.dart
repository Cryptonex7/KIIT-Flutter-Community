import 'package:flutter/material.dart';
import 'main.dart';

class Hello extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new Center(
        child: Center(child:Text("HELLO BRO",style: new TextStyle(fontFamily: "Montserrat-Medium",color: Colors.deepOrange,fontSize: 50,letterSpacing: 1)),),
      ),
    );
  }
}
