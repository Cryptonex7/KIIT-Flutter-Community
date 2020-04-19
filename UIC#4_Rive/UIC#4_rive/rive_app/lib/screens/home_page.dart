import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

Widget buildText(BuildContext context, text) {
  return Container(
      padding: EdgeInsets.all(20),
      margin: EdgeInsets.all(10),
      child: Text(text, style: Theme.of(context).textTheme.title));
}

Widget buildImage(url) {
  return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: Image.asset(
        url,
        fit: BoxFit.cover,
        width: 450,
        height: 400,
      ));
}

Widget buildTopic(text) {
  return Text(
    text,
    style: TextStyle(
        fontSize: 40, fontWeight: FontWeight.bold, color: Colors.purple),
    textAlign: TextAlign.center,
  );
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(10),
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              buildTopic('#Corona Haarega India Jeetega'),
              SizedBox(height: 20),
              buildImage('assets/_1.jpg'),
              SizedBox(height: 20),
              Divider(
                thickness: 5,
                color: Colors.grey,
              ),
              SizedBox(height: 20),
              buildTopic('#Work from Home'),
              SizedBox(height: 20),
              buildImage('assets/_4.jpg'),
              buildText(context, '1.Hold meetings, have collaborative conversations and share files, wherever individual members of your team are.\n2. Boost your productivity with meeting recording, screen sharing and remote collaboration on documents.\n3. A one-stop solution for all your communication needs, with unlimited messaging, scheduling, chat and search capabilities.'),
              SizedBox(height: 20),
              Divider(
                thickness: 5,
                color: Colors.grey,
              ),
              SizedBox(height: 20),
              buildTopic('Guidelines by UNICEF'),
              SizedBox(height: 20),
              buildImage('assets/_2.jpg'),
              SizedBox(height: 20),
              Divider(
                thickness: 5,
                color: Colors.grey,
              ),
              SizedBox(height: 20),
              buildTopic('CovidVisualiser'),
              SizedBox(height: 20),
              buildImage('assets/_5.jpg'),
              buildText(context, 'Covidvisualiser.com- is a website which provides the latest of the latest information about coronavirus in the best interactive way. \nYou can hover over any country to check its total number of cases and deaths due to coronavirus.'),
              SizedBox(height: 20),
              Divider(
                thickness: 5,
                color: Colors.grey,
              ),
              SizedBox(height: 20),
              buildTopic('Symptoms To Be Checked'),
              SizedBox(height: 20),
              buildImage('assets/_3.jpg'),
              SizedBox(height: 20),
              RaisedButton(
                  onPressed: () =>launch('https://covid.bhaarat.ai/'),
                  color: Colors.grey,
                  child: Text(
                    'Check Your Symptoms Now',
                  )),
            ],
          ),
        ));
    //drawer: Drawer(),
    // bottomNavigationBar: FlareActor('assets/Nav Bar.flr'),
  }
}
