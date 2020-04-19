import 'screens/tab_screen.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'screens/settings_page.dart';
import 'widgets/app_theme.dart';
import 'package:flare_loading/flare_loading.dart';

void main() {
  runApp(ChangeNotifierProvider<AppStateNotifier>(
      create: (context) => AppStateNotifier(), child: MyApp()));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  @override
  Widget build(BuildContext context) {
    return Consumer<AppStateNotifier>(
      builder: (context, appState, child) {
        return MaterialApp(
          title: '#UIC4',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme, // ThemeData(primarySwatch: Colors.blue),
          darkTheme:
              AppTheme.darkTheme, // ThemeData(primarySwatch: Colors.blue),
          themeMode: appState.isDarkMode ? ThemeMode.dark : ThemeMode.light,
      home: MyHomePage(),
      routes: {
        TabScreen.routeName: (ctx) => TabScreen(),
      },
    );});
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: FlareLoading(
            name: 'assets/splash_screen.flr',
            fit: BoxFit.cover,
            startAnimation: 'Untitled',
            onError: null,
            onSuccess: (data) {
              setState(() {
                Navigator.of(context).pushReplacementNamed(TabScreen.routeName);
              });
              
            }),
      ),
    );
  }
}
