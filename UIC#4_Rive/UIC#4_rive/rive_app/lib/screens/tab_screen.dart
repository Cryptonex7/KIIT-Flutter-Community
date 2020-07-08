import 'about_page.dart';
import '../widgets/app_drawer.dart';
import 'gps_page.dart';
import 'home_page.dart';
import 'settings_page.dart';
import '../widgets/navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flare_loading/flare_loading.dart';

class TabScreen extends StatefulWidget {
  static const routeName = 'tabscreen';

  @override
  _TabScreenState createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  List<Map<String, Object>> _pages = [
    {'title': 'Cororna Updates', 'page': HomePage()},
    {'title': 'Settings', 'page': SettingsPage()},
    {'title': 'Your Location', 'page': GpsPage()},
    {'title': 'About Us', 'page': AbouPage()},
  ];
  int _selectedPageIndex = 0;
  bool isLoaded = false;
  void selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
      isLoaded = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_pages[_selectedPageIndex]['title']),
      ),
      drawer: AppDrawer(),
      body: Container(
        child: isLoaded
            ? _pages[_selectedPageIndex]['page']
            : Container(
                height: MediaQuery.of(context).size.height,
                width: double.infinity,
                child: FlareLoading(
                    name: 'assets/loader-ready.flr',
                    height: 150,
                    startAnimation: 'loading',
                    onError: null,
                    onSuccess: (data) {
                      setState(() {
                        isLoaded = true;
                      });
                    })),
      ),
      bottomNavigationBar: Container(child: SmartFlareAnimation(selectPage)),
    );
  }
}
