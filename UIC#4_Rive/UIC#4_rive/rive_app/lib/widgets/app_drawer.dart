import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flare_loading/flare_loading.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Container(
      child: Column(children: <Widget>[
        Container(
            
            height: 150,
            width: double.infinity,
            padding: EdgeInsets.all(20),
            alignment: Alignment.centerLeft,
            child: Text(
              "Stay Safe \nStay Connected \nStay Productive",
              style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 30,
                  color: Theme.of(context).primaryColor),
            )),
        Divider(
          thickness: 5,
          color: Colors.grey,
        ),
        SizedBox(height:20,),
        Container(
          height: 50,
          child: FlatButton(
              padding: EdgeInsets.all(10),
              color: Colors.grey,
              onPressed: () =>launch('https://www.who.int/emergencies/diseases/novel-coronavirus-2019'),
              child: Text(
                'WHO Latest Report',
              )),
        ),
        SizedBox(height:20,),
   Divider(
          thickness: 5,
          color: Colors.grey,
        ),
        SizedBox(height:20,),
        GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
              height: 200.0,
              child: Card(
                margin: EdgeInsets.all(10),
                elevation: 50,
                color: Color.fromRGBO(255, 254, 229, 1),
                child: FlareLoading(name:
                  'assets/Arrow.flr',
                  loopAnimation: 'LTR',
                  onError: null,
                  onSuccess: null,
                ),
              )),
        ),
        SizedBox(height:20,),
Divider(
          thickness: 5,
          color: Colors.grey,
        ),
      ]),
    ));
  }
}
