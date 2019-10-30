import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myapp/me/auth/auth.dart';
import 'package:myapp/model/user.dart';

class SignInUpPage extends StatefulWidget {
  final int indexTab;
  const SignInUpPage({Key key, @required this.indexTab})
      : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return SignInUpPageState(this.indexTab);
  }
}

class SignInUpPageState extends State<SignInUpPage> {
  final int indexTab;

  SignInUpPageState(this.indexTab);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      resizeToAvoidBottomInset: true,
      resizeToAvoidBottomPadding: true,
      body: Container(
        margin: EdgeInsets.only(top: 15),
        child: Form(
          child: Column(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                    border: Border(
                        top: BorderSide(width: 0.3),
                        bottom: BorderSide(width: 0.3))),
                child: TextFormField(
                  autofocus: true,
                  maxLines: 1,
                  decoration: InputDecoration(
                      hintText: "Email",
                      contentPadding: EdgeInsets.all(13),
                      border: new UnderlineInputBorder(
                        borderSide:
                            BorderSide(style: BorderStyle.none, width: 0),
                        borderRadius: BorderRadius.circular(0),
                      ),
                      fillColor: Colors.white,
                      filled: true),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    border: Border(
                        top: BorderSide(width: 0.3),
                        bottom: BorderSide(width: 0.3))),
                child: TextFormField(
                  maxLines: 1,
                  decoration: InputDecoration(
                      hintText: "Mật khẩu",
                      // focusedBorder: ,
                      contentPadding: EdgeInsets.all(13),
                      border: OutlineInputBorder(
                        borderSide:
                            BorderSide(style: BorderStyle.none, width: 0),
                        borderRadius: BorderRadius.circular(0),
                      ),
                      fillColor: Colors.white,
                      filled: true),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 7),
                width: MediaQuery.of(context).size.width,
                child: MaterialButton(
                  disabledColor: Colors.grey,
                  padding: EdgeInsets.all(15),
                  textColor: Colors.white,
                  color: Colors.red,
                  child:
                      this.indexTab == 0 ? Text("Đăng nhập") : Text("Đăng ký"),
                  onPressed: () {
                    // Navigator.pop(authContext);
                  },
                ),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        // padding: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(bottom: 7),
              child: MaterialButton(
                padding: EdgeInsets.all(15),
                textColor: Colors.white,
                color: Colors.red,
                child: Text("Đăng nhập bằng Google"),
                onPressed: () {
                  UserService().signIn(context).then((f) {
                    Navigator.pop(AuthPageState.authKey.currentContext);
                  });
                },
              ),
            ),
            MaterialButton(
              textColor: Colors.white,
              padding: EdgeInsets.all(15),
              color: Colors.blue,
              child: Text("Đăng nhập bằng Facebook"),
              onPressed: () {
                // UserService().signInWithFb(context);
              },
            )
          ],
        ),
      ),
    );
  }
}
