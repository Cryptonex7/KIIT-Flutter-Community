import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/material.dart';
import '../widgets/small_news_card.dart';

class WidgetTestingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DynamicTheme.of(context).data.backgroundColor,
      appBar: AppBar(
        title: Text('I am testing my widget...'),
      ),
      body: Container(
        padding: EdgeInsets.all(5),
        child: Column(
          children: <Widget>[
            SmallNewsCard(
              title:
                  "Students suffering from fever, cold and cough due to heavy rain and change in weather. Corona is showing it's effects",
              image: "https://static.toiimg.com/photo/72995118.cms",
              body:
                  "A sudden rainfall and change in weather in the night has caused the cold, fever and coughing to many students in the college. The college administration is willing to take strong action in this concern. This will continue if the students will not take care of themselves, said the hostel warden of KP-6. Many students are advised to get admitted in the hospital nearby to avoid the worst circumstances. ",
              subtitle:
                  "This is the effect of corona and this will continue if not taken care. Testing the subtitle property...",
              date: "16-March-2020",
            )
          ],
        ),
      ),
    );
  }
}
