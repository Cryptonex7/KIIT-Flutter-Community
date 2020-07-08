import 'package:flare_flutter/flare_actor.dart';
import 'package:flare_loading/flare_loading.dart';
import 'package:flutter/material.dart';
import 'package:flare_flutter/flare_controls.dart';

class GpsPage extends StatefulWidget {
  @override
  _GpsPageState createState() => _GpsPageState();
}

class _GpsPageState extends State<GpsPage> {
  final FlareControls animationControls = FlareControls();
  bool ison = false;
  bool isImage = false;
  bool isSad = true;
  bool isCheck=false;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 720,
      width: MediaQuery.of(context).size.width,
      child: SingleChildScrollView(
              child: Column(
          children: <Widget>[
            Text('Tap To Access Your Location',style: Theme.of(context).textTheme.title),
            Switch(
              onChanged: (bool state) {
                setState(() {
                  ison = state;
                });
                print(state);
              },
              value: ison,
            ),
            ison
                ? Container(
                    height: 200.0,
                    child: FlareLoading(
                      name: 'assets/location_place_holder.flr',
                      startAnimation: 'jump',
                      onError: null,
                      onSuccess: (data) {
                        setState(() {
                          isImage = true;
                          ison = false;
                          isSad = false;
                        });
                      },
                    ))
                : isSad
                    ? Container(
                        height: 200.0,
                        child: FlareActor(
                          'assets/sad.flr',
                          animation: 'idle',
                          
                        ))
                    : SizedBox(),
            isImage
                ? ClipRRect(
                    
                    borderRadius: BorderRadius.circular(15),
                    child: Image.asset(
                      'assets/images.jpg',
                      fit: BoxFit.cover,
                      width: 250,
                      height:300,
                      
                    ))
                : SizedBox(),
            SizedBox(height: 10),
            isImage
                ? Column(children:[
                  Text('No COVID Positive Case Reported Near Your Location',style: Theme.of(context).textTheme.title),
                  SizedBox(height:10),
                  RaisedButton(autofocus: true,
                  padding: EdgeInsets.all(10),
                  elevation: 10,
                    color: Colors.grey,
                    onPressed: () {
                      setState(() {
                        isCheck=true;
                      });
                    },
                    child: Text(
                      'Report A Positive COVID Case in Your Location',
                      style: Theme.of(context).textTheme.title
                      
                    ))])
                : SizedBox(),
                isCheck?Container(
                  height: 200,
                  child: FlareLoading(
                        name: 'assets/check.flr',
                        startAnimation: 'run',
                        onError: null,
                        onSuccess: (data) {
                          setState(() {
                            isCheck=false;
                          });
                        },
                      ),
                ):SizedBox(),
          ],
        ),
      ),
    );
  }
}
