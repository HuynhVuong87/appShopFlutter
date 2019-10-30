import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myapp/me/auth/signinup.dart';

class AuthPage extends StatefulWidget {
  final int indexTab;

  const AuthPage({Key key, @required this.indexTab}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return AuthPageState(this.indexTab);
  }
}

class AuthPageState extends State<AuthPage> with TickerProviderStateMixin {
  final int indexTab;
  static GlobalKey authKey = new GlobalKey();
  AuthPageState(this.indexTab);

  TabController _tabController;
  @override
  void initState() {
    _tabController =
        new TabController(length: 2, vsync: this, initialIndex: indexTab);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      key: authKey,
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: Colors.grey[200],
          appBar: AppBar(
            title: TabBar(
              controller: _tabController,
              tabs: <Widget>[
                Container(
                  height: AppBar().preferredSize.height,
                  child: Tab(text: "Đăng nhập"),
                ),
                Tab(text: "Đăng ký")
              ],
            ),
            actions: <Widget>[
              IconButton(
                iconSize: 30,
                // color: Colors.red[300],
                icon: Icon(Icons.highlight_off),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          ),
          body: TabBarView(
            children: <Widget>[
              SignInUpPage(indexTab: 0),
              SignInUpPage(indexTab: 1)
            ],
            controller: _tabController,
          ),
        ),
      ),
    );
  }
}
