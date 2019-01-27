import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_posts_redux/redux/app/app_state.dart';
import 'package:flutter_posts_redux/ui/dashboard/dashboard_page1.dart';
import 'package:flutter_posts_redux/ui/dashboard/dashboard_page2.dart';
import 'package:flutter_posts_redux/ui/dashboard/dashboard_page3.dart';
import 'package:flutter_posts_redux/localizations.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

class DashboardScreen extends StatefulWidget {
  static const String route = '/dash';

  @override
  State<StatefulWidget> createState() {
    return _DashboardScreenState();
  }
}

class _DashboardScreenState extends State<DashboardScreen> {

  int _currentIndex = 0;

  final List<Widget> _children = [
    DashboardPage1(),
    DashboardPage2(),
    DashboardPage3()
  ];

  @override
  Widget build(BuildContext context) {
    var store = StoreProvider.of<AppState>(context) as Store;

    return Scaffold(
            appBar: new AppBar(
              title: new Text(
                AppLocalizations.instance.text('title'),
              ),
            ),
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: _currentIndex,
              type: BottomNavigationBarType.fixed,
              onTap: onTabTapped,
              items: [
                BottomNavigationBarItem(
                  icon: new Icon(Icons.dashboard),
                  title: new Text(AppLocalizations.instance.text('page_one')),
                ),
                BottomNavigationBarItem(
                  icon: new Icon(Icons.gesture),
                  title: new Text(AppLocalizations.instance.text('page_two')),
                ),
                BottomNavigationBarItem(
                    icon: Icon(Icons.timelapse),
                    title: Text(AppLocalizations.instance.text('page_three')))
              ],
            ),
            body: _children[_currentIndex]);
  }


  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
