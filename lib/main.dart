import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myapp/home/home.dart';
import 'package:myapp/me/home.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  State<StatefulWidget> createState() {
    return MyAppState();
  }
}

class MyAppState extends State<MyApp> {
  int _selectedPage = 0;
  final _pageOptions = [
    HomePage(),
    Text("Item 2"),
    GoogleSignApp(),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome to My app',
      theme: ThemeData(primarySwatch: Colors.deepOrange),
      home: CupertinoTabScaffold(
        tabBar: CupertinoTabBar(
          inactiveColor: Colors.black54,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text('Home', style: TextStyle(fontSize: 13),),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.bubble_chart),
              title: Text('Support', style: TextStyle(fontSize: 13),),
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.profile_circled),
              title: Text('Me', style: TextStyle(fontSize: 13),),
            ),
          ],
          currentIndex: _selectedPage,
          onTap: (int index) {
            setState(() {
              _selectedPage = index;
            });
          },
        ),
        tabBuilder: (BuildContext context, int index) {
          return CupertinoTabView(
            builder: (BuildContext context) => _pageOptions[index],
            defaultTitle: 'Shop',
          );
        },
      ),
    );
  }
}
