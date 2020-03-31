import 'package:college_news_blog/pages/splash_page.dart';
import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DynamicTheme(
      defaultBrightness: Brightness.light,
      data: (Brightness brightness) {
        if (brightness == Brightness.dark) {
          return ThemeData(
            brightness: brightness,
            cardTheme: CardTheme(
              color: Colors.black26
            ),
            backgroundColor: Color(0xFF2E2E2E),
            scaffoldBackgroundColor: Color.fromARGB(255, 55, 55, 55),
            iconTheme: IconThemeData(
              color: Colors.grey
            ),
            textTheme: TextTheme(
              title: TextStyle(
                color: Colors.white70
              ),
              subtitle: TextStyle(
                color: Color.fromARGB(255, 187, 187, 187)
              ),
            )
          );
        } else {
          return ThemeData(
            brightness: brightness,
            cardTheme: CardTheme(
              color: Colors.white
            ),
            scaffoldBackgroundColor: Colors.white,
            backgroundColor: Color(0xFFF9F9F9),
            iconTheme: IconThemeData(
              color: Colors.black
            ),
            textTheme: TextTheme(
              title: TextStyle(
                color: Colors.white
              ),
            )
          );
        }
      },
      themedWidgetBuilder: (context, theme) {
        return new MaterialApp(
          theme: theme,
          debugShowCheckedModeBanner: false,
          title: 'ColNews Blogger',
          home: new SplashPage(),
        );
      },
    );
  }
}