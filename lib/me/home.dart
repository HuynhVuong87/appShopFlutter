import 'dart:ffi';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:myapp/me/auth/auth.dart';
import 'package:myapp/model/user.dart';

import 'account.dart';

class GoogleSignApp extends StatefulWidget {
  @override
  _GoogleSignAppStates createState() => _GoogleSignAppStates();
}

class _GoogleSignAppStates extends State<GoogleSignApp> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = new GoogleSignIn();
  UserDetails details;

  Future<FirebaseUser> _signIn(BuildContext context) async {
    Scaffold.of(context).showSnackBar(new SnackBar(
      content: new Text("Sign In"),
    ));
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;
    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    FirebaseUser userDetails =
        await _firebaseAuth.signInWithCredential(credential);
    ProviderDetails providerInfo = new ProviderDetails(userDetails.providerId);
    List<ProviderDetails> providerData = new List<ProviderDetails>();
    providerData.add(providerInfo);
    setState(() {
      details = new UserDetails(userDetails.providerId, userDetails.displayName,
          userDetails.photoUrl, userDetails.email, providerData);
    });
    return userDetails;
  }

  account(BuildContext context) {
    if (details != null)
      Navigator.of(context).push(CupertinoPageRoute<Void>(
          title: "Thông tin",
          builder: (BuildContext context) =>
              ProfileScreen(detailsUser: details)));
  }

  Widget rowWidget(IconData icon, Color color, String title, bool border) {
    BoxDecoration borderBottom;
    if (border) {
      borderBottom = BoxDecoration(
          border: Border(bottom: BorderSide(width: 0.5, color: Colors.black)));
    } else {
      borderBottom = BoxDecoration();
    }

    return new GestureDetector(
        onTap: () {
          if (icon == FontAwesomeIcons.user) account(context);
        },
        child: new Container(
          height: 60.0,
          padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
          decoration: borderBottom,
          child: new Row(
            children: <Widget>[
              new Container(
                padding: EdgeInsets.only(right: 15.0),
                child: new Icon(
                  icon,
                  color: color,
                ),
              ),
              new Expanded(
                child: new Text(
                  '$title',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              new Icon(Icons.keyboard_arrow_right),
            ],
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    Widget avatar() {
      if (details == null) {
        return Icon(
          CupertinoIcons.profile_circled,
          color: Colors.white,
          size: 50.0,
        );
      } else {
        return CircleAvatar(
          backgroundImage: NetworkImage(details.photoUrl),
          radius: 25.0,
        );
      }
    }

    Widget buttonOr(BuildContext context) {
      Widget widget;
      details == null
          ? widget = Container(
              child: Row(
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  MaterialButton(
                    color: Colors.white,
                    textColor: Colors.orange,
                    padding: EdgeInsets.all(0),
                    child: const Text("Đăng nhập"),
                    onPressed: () => {
                      if (User.id == null)
                        {
                          Navigator.of(context, rootNavigator: true).push(
                              MaterialPageRoute(
                                  builder: (BuildContext context) {
                            return AuthPage(indexTab: 0);
                          }))
                        }
                      else
                        {print("object")}
                    },
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 10),
                    child: MaterialButton(
                      color: Colors.orange,
                      shape: Border.all(width: 1, color: Colors.white),
                      textColor: Colors.white,
                      padding: EdgeInsets.all(0),
                      child: const Text("Đăng ký"),
                      onPressed: () => {
                        if (User.id == null)
                          {
                            Navigator.of(context, rootNavigator: true).push(
                                MaterialPageRoute(
                                    builder: (BuildContext context) {
                              return AuthPage(indexTab: 1);
                            }))
                          }
                        else
                          {print("object")}
                      },
                    ),
                  )
                ],
              ),
            )
          : widget = Text(
              details.userName,
              style: TextStyle(fontSize: 25, color: Colors.white),
            );
      return widget;
    }

    return new MaterialApp(
      home: new Scaffold(
        backgroundColor: Colors.grey[200],
        body: Builder(
          builder: (contextBuilder) => new CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                backgroundColor: Colors.orange,
                expandedHeight: 130,
                flexibleSpace: FlexibleSpaceBar(
                  background: Container(
                      padding: EdgeInsets.all(15),
                      height: 50,
                      child: Column(
                        children: <Widget>[
                          Spacer(),
                          Row(
                            children: <Widget>[
                              avatar(),
                              Spacer(),
                              buttonOr(contextBuilder),
                            ],
                          ),
                        ],
                      )),
                ),
                actions: <Widget>[
                  details == null
                      ? Container()
                      : IconButton(
                          color: Colors.white,
                          icon: Icon(
                            FontAwesomeIcons.cog,
                            size: 18,
                          ),
                          onPressed: () => account(context)),
                  IconButton(
                    color: Colors.white,
                    icon: Icon(
                      FontAwesomeIcons.shoppingCart,
                      // size: 18,
                    ),
                    onPressed: () => {},
                  ),
                  IconButton(
                    color: Colors.white,
                    icon: Icon(
                      FontAwesomeIcons.solidCommentDots,
                      // size: 18,
                    ),
                    onPressed: () => {},
                  )
                ],
              ),
              SliverToBoxAdapter(
                child: Container(
                  margin: EdgeInsets.only(top: 10.0),
                  padding: EdgeInsets.only(right: 15.0, left: 15.0),
                  color: Colors.white,
                  child: new Column(
                    children: <Widget>[
                      rowWidget(
                          Icons.event_note, Color(0xFF3c74b4), "Đơn mua", true),
                      rowWidget(Icons.phonelink_ring, Colors.green,
                          "Đơn nạp & Dịch vụ", false),
                    ],
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Container(
                  margin: EdgeInsets.only(top: 10.0),
                  padding: EdgeInsets.only(right: 15.0, left: 15.0),
                  color: Colors.white,
                  child: new Column(
                    children: <Widget>[
                      rowWidget(
                          Icons.favorite_border, Colors.red, "Đã thích", true),
                      rowWidget(Icons.access_time, Color(0xFF3c74b4), "Mới xem",
                          true),
                      rowWidget(
                          Icons.star, Colors.green, "Đánh giá của tôi", false),
                    ],
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Container(
                  margin: EdgeInsets.only(
                      top: 10.0,
                      bottom: MediaQuery.of(context).padding.bottom +
                          MediaQuery.of(context).viewInsets.bottom),
                  padding: EdgeInsets.only(right: 15.0, left: 15.0),
                  color: Colors.white,
                  child: new Column(
                    children: <Widget>[
                      rowWidget(FontAwesomeIcons.user, Color(0xFF3c74b4),
                          "Thiết lập tài khoản", false),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class UserDetails {
  final String providerDetails;
  final String userName;
  final String photoUrl;
  final String userEmail;
  final List<ProviderDetails> providerData;
  UserDetails(this.providerDetails, this.userName, this.photoUrl,
      this.userEmail, this.providerData);
}

class ProviderDetails {
  final String providerDetails;
  ProviderDetails(this.providerDetails);
}
