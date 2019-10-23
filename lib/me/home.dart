import 'dart:ffi';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';

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
          ? widget = RaisedButton(
              color: Colors.white,
              child: const Text("Login with Google",
                  style: TextStyle(fontSize: 21, color: Colors.orange)),
              onPressed: () => {_signIn(context)},
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
          builder: (contextBuilder) => new ListView(
            children: <Widget>[
              new Container(
                  color: Colors.orange[600],
                  child: new Column(
                    children: <Widget>[
                      //row 1
                      new Row(
                        children: <Widget>[
                          //icon1
                          new Expanded(
                            child: new Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                            ),
                          ),
                          details != null
                              ? new IconButton(
                                  color: Colors.white,
                                  icon: Icon(FontAwesomeIcons.cog),
                                  onPressed: () => account(context))
                              : SizedBox(),
                          new IconButton(
                            color: Colors.white,
                            icon: Icon(FontAwesomeIcons.cartPlus),
                            onPressed: () => {},
                          ),
                          new IconButton(
                            color: Colors.white,
                            icon: Icon(FontAwesomeIcons.solidCommentDots),
                            onPressed: () => {},
                          ),
                        ],
                      ),
                      //row 2
                      new Container(
                        padding:
                            const EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 20.0),
                        child: new Column(
                          children: <Widget>[
                            new Row(
                              children: <Widget>[
                                //avatar
                                new Expanded(
                                  child: new Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[avatar()],
                                  ),
                                ),
                                //user name or button login
                                buttonOr(contextBuilder)
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  )),
              new Container(
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
              new Container(
                margin: EdgeInsets.only(top: 10.0),
                padding: EdgeInsets.only(right: 15.0, left: 15.0),
                color: Colors.white,
                child: new Column(
                  children: <Widget>[
                    rowWidget(
                        Icons.favorite_border, Colors.red, "Đã thích", true),
                    rowWidget(
                        Icons.access_time, Color(0xFF3c74b4), "Mới xem", true),
                    rowWidget(
                        Icons.star, Colors.green, "Đánh giá của tôi", false),
                  ],
                ),
              ),
              new Container(
                margin: EdgeInsets.only(
                    top: 10.0,
                    bottom: MediaQuery.of(context).padding.bottom +
                        MediaQuery.of(context).viewInsets.bottom +
                        10.0),
                padding: EdgeInsets.only(right: 15.0, left: 15.0),
                color: Colors.white,
                child: new Column(
                  children: <Widget>[
                    rowWidget(FontAwesomeIcons.user, Color(0xFF3c74b4),
                        "Thiết lập tài khoản", false),
                  ],
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
