import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:myapp/me/home.dart';

class ProfileScreen extends StatelessWidget {
  final UserDetails detailsUser;
  final GoogleSignIn _gSignIn = GoogleSignIn();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  ProfileScreen({Key key, @required this.detailsUser}) : super(key: key);

  _signOut(BuildContext context) async {
    await _gSignIn.signOut();
    await _firebaseAuth.signOut().then((_) {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => GoogleSignApp()),
        ModalRoute.withName('/'),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Thông tin"),
        automaticallyImplyLeading: true,
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircleAvatar(
              backgroundImage: NetworkImage(detailsUser.photoUrl),
              radius: 50.0,
            ),
            SizedBox(
              height: 10.0,
            ),
            Text(
              "Name: " + detailsUser.userName,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 20.0),
            ),
            Text(
              "Email: " + detailsUser.userEmail,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 20.0),
            ),
            Text(
              "Provider: " + detailsUser.providerDetails,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 20.0),
            ),
            MaterialButton(
              child: Text(
                "Sign Out",
                style: TextStyle(fontSize: 20),
              ),
              textColor: Colors.white,
              color: Colors.red,
              onPressed: () => _signOut(context),
            )
          ],
        ),
      ),
    );
  }
}
